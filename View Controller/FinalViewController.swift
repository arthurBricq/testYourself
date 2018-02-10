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
    @IBOutlet var globalView: UIView!
    
    // MARK : variables
    let gradient = CAGradientLayer()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        updateTheScoreOfThePlayer()
        
        let delta:CGFloat = 30 // à vérifier avec la subclass de la view. Il s'agit du décalage entre la gauche du graphe (ou sa droite) et le bord de la view
        stackWIdth.constant = graphView.layer.bounds.width - delta
        updateStackView()
        updateTheBottomView()
        updateTHeGRaphView()
        
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
    
    func updateTheBottomView() { /*
         Cette fonction s'occupe de la gestion de l''espace de la vue du bas qui doit être glissée vers la gauche pour revenir au menu. 
    */
        let width = self.view.bounds.width
        backStackView.spacing = 0.25*width
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
        
        for partOfQuizz in activeQuizz.allQuestions {
            for answer in partOfQuizz.answers {
                
                
            }
        }
        
    }
    
    func updateTHeGRaphView() {
        graphView.layer.shadowColor = UIColor.black.cgColor
        graphView.layer.shadowOpacity = 0.4
        graphView.layer.shadowRadius = 8
        graphView.layer.shadowOffset = CGSize(width: 5, height: 5)
    }
}
    


