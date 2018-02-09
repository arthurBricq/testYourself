//
//  GameViewController.swift
//  testYourself
//
//  Created by Arthur BRICQ on 05/02/2018.
//  Copyright © 2018 Arthur BRICQ. All rights reserved.
//

import UIKit

class GameViewController: UIViewController
{
    // MARK : Outlets
    @IBOutlet var globalView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cardHeigh: NSLayoutConstraint!
    @IBOutlet weak var carWidth: NSLayoutConstraint!
    @IBOutlet weak var verticalCardCenter: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var tableViewWidth: NSLayoutConstraint!
    @IBOutlet weak var tableView: UIView!
    @IBOutlet var progressionLabelWidth: NSLayoutConstraint!
    @IBOutlet weak var cardViewCenterX: NSLayoutConstraint!
    @IBOutlet weak var cardViewCenterY: NSLayoutConstraint!
    @IBOutlet weak var progression: UIProgressView!
    
    
    
    // MARK : variables
    let gradient = CAGradientLayer()
    
    
    
    override func viewDidLoad()
    {
        // We are going to arrange the view as we want it.
        super.viewDidLoad()
        
        // Creating the gradient :
        var expension = CGAffineTransform()
        expension.a = 3
        expension.d = 2
        expension.tx = -100
        expension.ty = -150
        print(expension)
        gradient.frame = globalView.frame.applying(expension)
        print(gradient.frame)
        let myColor = UIColor(red: 255/255, green: 168/255, blue: 52/255, alpha: 0.7)
        gradient.colors = [ myColor.cgColor , UIColor.clear.cgColor]
        gradient.transform = CATransform3DMakeRotation(0*CGFloat.pi / 12, 0, 0, 1)
        globalView.layer.insertSublayer(gradient, at: 0)
        
        // Arranging the card view as we want :
        // 1) The card view layer
        cardHeigh.constant = globalView.frame.height*0.65
        carWidth.constant = globalView.frame.width*0.9
        cardView.layer.cornerRadius = 20
        progressionLabelWidth.constant = carWidth.constant
        // 2) The title label
        titleLabel.text = "Question number 1"
        titleLabel.textColor = cardView.backgroundColor?.withAlphaComponent(1)
        // 3) The text field.
        textView.backgroundColor = UIColor.white.withAlphaComponent(0)
        textView.isUserInteractionEnabled = false
        // 4) Setting the table view.
        tableViewWidth.constant = carWidth.constant - 20
        tableView.backgroundColor = UIColor.clear
        // 5) Update the text view :
        updateTextView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func updateTextView() {
        textView.text = activeQuizz.allQuestions[activeQuestionIdentifier].questionLabel
        
        titleLabel.text = "Question Number \(activeQuestionIdentifier+1)"
        
        let totalNumberOfQuestions = activeQuizz.allQuestions.count
        let progress = Float(activeQuestionIdentifier+1)/Float(totalNumberOfQuestions)
        progression.setProgress(progress, animated: true)
        print("progress : \(progress)")
    }
    
    // MARK : PanGestureRecognizer ------------------------------------
    
    var hasToChangeTheView = false
    var isChangingTheView = false // Cette variable sert à ce que les segues ne soient pas appeler plusieurs fois lorsque la variable 'hasToChangeTheView' devient vrai.
    var hasToComeBackToIdentity = true // On utilise cette variable pour que la vue ne revienne pas en arrière lorsqu'elle est censée quitter la page.
    var isItFirstQuestion = true
    var isItLastQuestion = false
    
    @IBAction func slideTheView(_ sender: UIPanGestureRecognizer)
    {
        let pointLocation = sender.location(in: self.view)
        let viewCenter = cardView.center
        let height = self.view.frame.height
        let width = self.view.frame.width
        
        if sender.state == .began {
            // Lorsque l'utilisateur commence à appuyer.
            initialDiff = pointLocation.x - viewCenter.x
        }
        
        // Décalage de la vue avec le doight qui se déplace :`
        let x = pointLocation.x - initialDiff - width/2
        let r : CGFloat = 2*height
        let teta = asin(x/r)
        let tx = r*(1-cos(teta))
        let ty = r*sin(teta)
        var lastTeta = CGFloat()
        
        // ne fait pas les modification en suivant le doigt si la vue est en train de changer
        if !hasToChangeTheView { // On utilise cette variable pour faire la transformation lorsque l'utilisateur touche la carte.
            // fait la rotation et le deplacement en x et y de la vue
            let myRot = CGAffineTransform(rotationAngle: teta)
            let myTrans = CGAffineTransform(translationX: ty, y: tx)
            let finalTransform = myRot.concatenating(myTrans)
            cardView.transform = finalTransform
            if hasToChangeTheView == true {
                lastTeta = teta
            }
        }
        
        // si la norme de la velocite est au-dessus de 1500 ou si la vue sort de l'écran, signal qu'il faut changer de vue
        let velocity = sender.velocity(in: self.view)
        if norme(vector: velocity) >= 2000 {
            hasToChangeTheView = true
            print("overspeeding")
        }
        if tx+x > 2*width/3 || tx+x < -2*width/3 {
            hasToChangeTheView = true
        }
        
    
        if hasToChangeTheView { // Cela veut dire que cette variable vient d'être changé, et donc qu'une des conditions pour changer de vue a été complétée.
            if !isChangingTheView { // Cela permet de ne pas faire plusieurs appels à cette fonction (puisqu'elle agit trop rapidement)
                
                hasToChangeTheView = false
                isChangingTheView = true
                hasToComeBackToIdentity = false

                if tx+x > 0 // L'utilisateur jète la carte vers la droite (donc RETOUR EN ARRIERE)
                {
                    print("Doit partir vers la droite")
                    
                    
                    if isItFirstQuestion // Dans ce cas, on ne peut pas retourner en arrière. Il faut donc faire l'identité.
                    {
                        
                        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                            self.cardView.transform = CGAffineTransform.identity
                        })
                        isChangingTheView = false
                        hasToComeBackToIdentity = true
                        
                        
                    } else { // Cela veut dire que ce n'est pas a première question, donc on peut retourner en arrière
                        print("Doit partir vers la gauche")
                        UIView.animate(withDuration: 0.2, animations: { // On envoie la carte à droite de l'écran
                            self.cardViewCenterX.constant = +400
                            self.cardViewCenterY.constant = 80
                            self.view.layoutIfNeeded()
                        }, completion: { (tmp) in
                            self.swipingToPreviousQuestion(teta: lastTeta)
                        })
                    }
                    
                    
                    
                } else if tx + x < 0
                {
                    // On commence par tester s'il s'agit de la dernière question.
                    if activeQuestionIdentifier == activeQuizz.allQuestions.count-1 {
                        isItLastQuestion = true
                        print("Nous devons quitter cette page et passer au dernier ViewController ")
                    } else {
                        isItLastQuestion = false
                    }
                    
                    print(isItLastQuestion)
                    
                    if isItLastQuestion { // Si c'est la dernière question, il faut appeler le segue.
                        UIView.animate(withDuration: 0.2, animations: { // On envoie la carte vers la gauche (comme d'habitude)
                            self.cardViewCenterX.constant = -400
                            self.cardViewCenterY.constant = 80
                            self.view.layoutIfNeeded()
                        }, completion: { (tmp) in
                            // Partir sur la page suivante.
                            self.performSegue(withIdentifier: "LastSegue", sender: self)
                            
                        })
                    } else
                    { // Ce n'est pas la dernière question, donc il faut passer à la question suivante. Il faut juste vérifier qu'une réponse a bien été coché par l'utilisateur.
                        
                        let i = activeQuestionIdentifier
                        var isOneAnswerChecked = false // Cette variable indique 'true' s'il y a une réponse cochée.
                        let numberOfAnswers = activeQuizz.allQuestions[activeQuestionIdentifier].answers.count
                        let arrayWithAnswers = OneQuizzChecked[i] // C'est un tableau de booléan qui indique quelle réponse est cochée par true (si une réponse est cochée)
                        
                        for tmp in 0...numberOfAnswers-1 {
                            if arrayWithAnswers.isChecked[tmp] == true {
                                isOneAnswerChecked = true
                            }
                        }
                        
                        if isOneAnswerChecked {
                            print("il y a une réponse cochée")
                        } else {
                            print("il n'y a pas de réponse cochée")
                        }
                        
                        if isOneAnswerChecked
                        { // On peut donc passer à la question suivante.
                            UIView.animate(withDuration: 0.2, animations: { // On envoie la carte vers la gauche.
                                self.cardViewCenterX.constant = -400
                                self.cardViewCenterY.constant = 80
                                self.view.layoutIfNeeded()
                            }, completion: { (tmp) in
                                self.swipingToNextQuestion(teta: lastTeta)
                            })
                        } else
                        { // On ne peut pas passer à la question suivante. Il faut donc revenir à l'identité.
                            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                                self.cardView.transform = CGAffineTransform.identity
                            })
                            isChangingTheView = false
                            hasToComeBackToIdentity = true
                        
                        }
                        
    
                    }
                    
                    
                    
                }
            }
        }
        
        // quand on lache la vue
        if sender.state == .ended
        {
            if hasToComeBackToIdentity {
                isChangingTheView = false
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                    self.cardView.transform = CGAffineTransform.identity
                    print("Back After : \(self.cardView.transform)")
                })
            }
            
        }
        
        sender.setTranslation(CGPoint.zero, in: self.view)
    }

    func swipingToNextQuestion(teta: CGFloat) {
        // 1 -------- On passe à la question suivante et actualiser la tableView
        activeQuestionIdentifier += 1
        tableViewController.tableView.reloadData() // Cela permet d'actualiser les réponses
        updateTextView() // Cela permet d'actualiser la question.
        
        // 2 --------- On a besoin de faire apparaitre la vue par la gauche, commençons par la mettre à gauche.
        cardViewCenterX.constant = +400
        cardViewCenterY.constant = 80
        view.layoutIfNeeded()
        // 3 ----------- Puis il faut faire une rotation de -2teta pour la carte, avec teta qui est l'angle finale de rotation.
        cardView.transform = CGAffineTransform(rotationAngle: +2*teta)
        // 4---------- Puis on fait l'apparition
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseIn, animations: {
            self.cardViewCenterX.constant = 0
            self.cardViewCenterY.constant = 20
            self.view.layoutIfNeeded()
            
        }) { (tmp) in
        // 5 ---------Réactualiser les différentes variables de la logique.
            if self.isItFirstQuestion {
                self.isItFirstQuestion = false
            }
            self.hasToChangeTheView = false
            self.isChangingTheView = false // Cette variable sert à ce que les segues ne soient pas appeler plusieurs fois lorsque la variable 'hasToChangeTheView' devient vrai.
            self.hasToComeBackToIdentity = true // On utilise cette variable pour que la vue ne revienne pas en arrière lorsqu'elle est censée quitter la page.
        
        }
    }
    
    func swipingToPreviousQuestion(teta: CGFloat) {
        //1) Actualiser les données de l'ancienne carte :
        activeQuestionIdentifier -= 1
        tableViewController.tableView.reloadData()
        updateTextView()
        
        //2) Mettre l'ancienne carte à droite
        cardViewCenterX.constant = -400
        cardViewCenterY.constant = 80
        view.layoutIfNeeded()
        
        //3) Faire une rotation
        cardView.transform = CGAffineTransform(rotationAngle: -2*teta)

        //4) Faire apparaitre la carte
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseInOut, animations: {
            self.cardViewCenterX.constant = 0
            self.cardViewCenterY.constant = 20
            self.view.layoutIfNeeded()
        }) { (tmp) in
            if activeQuestionIdentifier == 0 {
                self.isItFirstQuestion = true
            }
            self.hasToChangeTheView = false
            self.isChangingTheView = false
            self.hasToComeBackToIdentity = true
        }
        
    }
    
    
    // MARK : Logics and functions to handle correctly the container view with the tableView inside it, as a child View.
    
    var tableViewController = UITableViewController() // This is the child view.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "TransitionToTableView")
        {
            print("the segue going to the table is done.")
            tableViewController = segue.destination as! QuestionTableViewController
            // Pass data to secondViewController before the transition
        }
    }
    
}
