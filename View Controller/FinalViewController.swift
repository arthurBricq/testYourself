//
//  FinalViewController.swift
//  testYourself
//
//  Created by Arthur BRICQ on 10/02/2018.
//  Copyright © 2018 Arthur BRICQ. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController {

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK : Outlets --------------------------
    @IBOutlet weak var stackWIdth: NSLayoutConstraint!
    @IBOutlet weak var grapViewWidth: NSLayoutConstraint!
    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var backStackView: UIStackView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet var globalView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    // MARK : variables
    let gradient = CAGradientLayer()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        updateTheScoreOfThePlayer()
        
        let delta:CGFloat = 30 // à vérifier avec la subclass de la view. Il s'agit du décalage entre la gauche du graphe (ou sa droite) et le bord de la view
        stackWIdth.constant = graphView.layer.bounds.width - delta
        updateStackView()
        updateTHeGraphView()
        
        // Creating a gradient :
        let beginningColor = UIColor(red: 248/255, green: 198/255, blue: 123/255, alpha: 1)
        let endColor = UIColor(red: 248/255, green: 198/255, blue: 123/255, alpha: 0.6)
        gradient.colors = [beginningColor.cgColor, endColor.cgColor]
        // tourne le gradiant d'un quart vers la gauche
        gradient.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        // met le gradiant de la taille de l'écran
        gradient.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        globalView.layer.insertSublayer(gradient, at: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) { /*
         On positionne la petit main grâce au spacing du stackView à droite de la vue visible
 */
        super.viewWillAppear(animated)
        let width = self.view.bounds.width
        backStackView.spacing = width
        canPerformTheSegue = true
        hasToComeBackToInitialPosition = true
        backView.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) { /*
         Ici, on fait apparaitre la petite main qui glisse grâce au spacing du stackView
 */
        super.viewDidAppear(animated)
        let width = self.view.bounds.width
        UIView.animate(withDuration: 0.6) {
            self.backStackView.spacing = 0.15*width
            self.view.layoutIfNeeded()
        }
    }

    func updateStackView() {
        label1.text = activeQuizz.properties[0]
        label2.text = activeQuizz.properties[1]
        label3.text = activeQuizz.properties[2]
        label4.text = activeQuizz.properties[3]
        label5.text = activeQuizz.properties[4]
        label6.text = activeQuizz.properties[5]

        stackView.sizeToFit()
        stackView.layoutIfNeeded()
        let stackHeight = stackView.bounds.height
        graphView.bottomMargin = stackHeight + 10
    }
   
    func updateTheScoreOfThePlayer()
    {
        
        // 1) Commençons par compter tous les nombres des points.
        var totalNumbersOfPoints: Int = 0
        var totalNumbersOfPointsPerCategory: [Int] = [0,0,0,0,0,0]
        
        for partOfQuizz in activeQuizz.allQuestions {
            for answer in partOfQuizz.answers {
                for i in 0..<6 {
                    let tmp = totalNumbersOfPointsPerCategory[i]
                    let toAdd = answer.benefits[i]
                    totalNumbersOfPointsPerCategory.remove(at: i)
                    totalNumbersOfPointsPerCategory.insert(tmp + toAdd, at: i)
                }
                totalNumbersOfPoints += answer.benefits.count
            }
        }
        print("total number of points to earn : \(totalNumbersOfPoints)")
        print("total number per category : \(totalNumbersOfPointsPerCategory)")

        
        // 2) Maintenant, on compte tous les points de l'utilisateur (donc uniquement ceux qui sont cochées)
        var scoreOfThePlayer: [Int] = [0,0,0,0,0,0]
        
        for partOfQuizzIdentifier in 0..<(activeQuizz.allQuestions.count)
        {
            let partOfQuizz = activeQuizz.allQuestions[partOfQuizzIdentifier]
            for answerIdentifier in 0..<(partOfQuizz.answers.count)
            {
                if OneQuizzChecked[partOfQuizzIdentifier].isChecked[answerIdentifier] {
                    // Cela veut dire que cette réponse a été coché positive.
                    let tableOfProperties = partOfQuizz.answers[answerIdentifier].benefits
                    
                    for i in 0..<6 { // Ici, on incrémente le tableau des scores
                        let tmp = scoreOfThePlayer[i]
                        let toAdd = tableOfProperties[i]
                        scoreOfThePlayer.remove(at: i)
                        scoreOfThePlayer.insert(tmp + toAdd, at: i)
                    }
                }
            }
        }
        
        
        
        print("score de l'utilisateur: \(scoreOfThePlayer)")
        
        // 3) Trouver les ratios pour chaque propriétés
        let maxPoints:CGFloat = 10*CGFloat(activeQuizz.allQuestions.count)
        
        for i in 0..<6 {
            score.remove(at: i)
            score.insert(CGFloat(scoreOfThePlayer[i])/maxPoints, at: i)
        }
        
        print("ratio de l'utilisateur: \(score)")
        
    }
    
    func updateTHeGraphView() {
        graphView.layer.shadowColor = UIColor.black.cgColor
        graphView.layer.shadowOpacity = 0.4
        graphView.layer.shadowRadius = 8
        graphView.layer.shadowOffset = CGSize(width: 5, height: 5)
    }
    
    var canPerformTheSegue = true
    var hasToComeBackToInitialPosition = true
    var scoreToSave: [CGFloat] = []
    
    @IBAction func handlePan(_ sender: UIPanGestureRecognizer)
    {
        let screenCenter = self.view.center
        let pointLocation = sender.location(in: self.view)
        let senderView = sender.view!
        
        // 1) On récupère la différence initiale entre le centre de la vue et le premier point où on appui.
        if sender.state == UIGestureRecognizerState.began {
            initialDiff = pointLocation.x - screenCenter.x
        }
        
        // 2) On déplace la vue.
        if hasToComeBackToInitialPosition {
            senderView.center.x = pointLocation.x - initialDiff

        }
        
        if senderView.center.x > screenCenter.x { // Si on retourne vers la droite, bloquer le mouvement.
            senderView.center.x = screenCenter.x
        }
        
        // 3) On fait en sorte que lorsque on lache l'écran, la vue revienne à sa position initiale.
        
       
        if sender.state == .ended
        {
            if hasToComeBackToInitialPosition {
                UIView.animate(withDuration: 0.5,delay : 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    senderView.center.x = screenCenter.x
                })
            }
           
        }
        
        let xPos = senderView.center.x
        let velocity = sender.velocity(in: self.view)
        let speed = norme(vector: velocity)
        if (xPos < -100) || (speed > 1999) { // Alors il faut passer à la vue suivante, c'est à dire le menu.
            if canPerformTheSegue
            {
                canPerformTheSegue = false
                hasToComeBackToInitialPosition = false
                scoreToSave = score
                
                UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
                    
                    senderView.center.x = -screenCenter.x
                    self.view.layoutIfNeeded()
                    
                }, completion: { (tmp) in
                    self.backView.isHidden = true
                    UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseInOut, animations: {
                        self.topConstraint.constant = -400
                        self.bottomConstraint.constant = -100
                        self.view.layoutIfNeeded()

                    }, completion: { (tmp1) in
                        
                        UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
                            // Just sleeping
                    

                        }, completion: { (tmp) in
                            
                            self.performSegue(withIdentifier: "BackToMenu", sender: self)
                            self.saveTheGame()
                        })
                        
                    })
                    
                    
                })
                
                
            }
            
        }
        
    }
    
    
    func saveTheGame() {
        let nameOfQuizz = activeQuizz.title
        let sexOfThePlayer: String
        if isAMale {
            sexOfThePlayer = "Male"
        } else {
            sexOfThePlayer = "Female"
        }
        let toSave = OneScore(name: name, gender: sexOfThePlayer, nameOfQuizz: nameOfQuizz, scores: scoreToSave)
        allScores.append(toSave)
        saveToFile(toSave: allScores)
    }
    
}
    


