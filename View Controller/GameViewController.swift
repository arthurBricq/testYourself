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
    
    
    // MARK : variables
    let gradient = CAGradientLayer()
    
    
    
    override func viewDidLoad()
    {
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
        cardHeigh.constant = globalView.frame.height*0.8
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
    }
    
    // MARK : PanGestureRecognizer
    
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
        
    
        if hasToChangeTheView { // Cela veut dire que cette variable vient d'être changé
            if !isChangingTheView { // Cela permet de ne pas faire plusieurs appels.
                hasToChangeTheView = false
                isChangingTheView = true
                hasToComeBackToIdentity = false

                if tx+x > 0 {
                    print("Doit partir vers la droite")
                    if isItLastQuestion { // Si c'est la dernière question, il faut appeler le segue.
                        
                    } else { // Ce n'est pas la dernière question, donc il faut passer à la question suivante.
                        UIView.animate(withDuration: 0.2, animations: {
                            self.cardViewCenterX.constant = 400
                            self.cardViewCenterY.constant = 80
                            self.view.layoutIfNeeded()
                        }, completion: { (tmp) in
                            print(lastTeta)
                            self.swipingRight(teta: lastTeta)
                        })
                    }
                    
                } else if tx + x < 0 {
                    if isItFirstQuestion // Dans ce cas, on ne peut pas retourner vers la gauche. Il faut donc faire l'identité.
                    {
                        
                        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                            self.cardView.transform = CGAffineTransform.identity
                        })
                        isChangingTheView = false
                        hasToComeBackToIdentity = true
                        
                        
                    } else { // Cela veut dire que ce n'est pas a première question/
                        print("Doit partir vers la gauche")
                        UIView.animate(withDuration: 0.2, animations: {
                            self.cardViewCenterX.constant = -400
                            self.cardViewCenterY.constant = 80
                            self.view.layoutIfNeeded()
                        }, completion: { (tmp) in
                            self.swipingLeft()
                        })
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

    func swipingRight(teta: CGFloat) {
        // 1 -------- On passe à la question suivante et actualiser la tableView
        activeQuestionIdentifier += 1
        tableView.layoutIfNeeded()
        // 2 --------- On a besoin de faire apparaitre la vue par la gauche, commençons par la mettre à gauche.
        cardViewCenterX.constant = -400
        cardViewCenterY.constant = 80
        view.layoutIfNeeded()
        // 3 ----------- Puis il faut faire une rotation de -2teta pour la carte, avec teta qui est l'angle finale de rotation.
        cardView.transform = CGAffineTransform(rotationAngle: -2*teta)
        // Puis on fait l'apparition
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseIn, animations: {
            self.cardViewCenterX.constant = 0
            self.cardViewCenterY.constant = 20
            self.view.layoutIfNeeded()
            
        }) { (tmp) in
        // 4 ---------Réactualiser les différentes variables de la logique.
            if self.isItFirstQuestion {
                self.isItFirstQuestion = false
            }
            self.hasToChangeTheView = false
            self.isChangingTheView = false // Cette variable sert à ce que les segues ne soient pas appeler plusieurs fois lorsque la variable 'hasToChangeTheView' devient vrai.
            self.hasToComeBackToIdentity = true // On utilise cette variable pour que la vue ne revienne pas en arrière lorsqu'elle est censée quitter la page.
        
        }
        
        
    }
    
    func swipingLeft() {
        activeQuestionIdentifier -= 1 // On passe à la question précedente
    }
    
}
