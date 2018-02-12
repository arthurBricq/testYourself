//
//  PreviousResultViewController.swift
//  testYourself
//
//  Created by Marin on 10/02/2018.
//  Copyright © 2018 Arthur BRICQ. All rights reserved.
//

import UIKit

class PreviousResultViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    let gradient = CAGradientLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Arranging the background (creating a gradient of color for the view)
        // set the colors
        let beginningColor = UIColor(red: 248/255, green: 198/255, blue: 123/255, alpha: 1)
        let endColor = UIColor(red: 248/255, green: 198/255, blue: 123/255, alpha: 0.6)
        gradient.colors = [beginningColor.cgColor, endColor.cgColor]
        // met le gradiant de la taille de l'écran
        gradient.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        self.view.layer.insertSublayer(gradient, at: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPressed(_ sender: customButton) {
        performSegue(withIdentifier: "BackToMenu", sender: self)
    }
    
    // function called when a cell is pressed in order to show the popover view correctly
    var quizUsedTitle: String = ""
    func showPopover(scoreToShow: OneScore) {
        // set the score for the GraphView and get the name of the quiz which was played in order to find its properties
        score = scoreToShow.scores
        quizUsedTitle = scoreToShow.nameOfQuizz
        performSegue(withIdentifier: "popoverSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // when a segue is performed if it's to the popover view, change the name of the quiz to find its properties
        if segue.identifier == "popoverSegue" {
            let nextVC = segue.destination as! PopoverViewController
            for quizz in allQuizz {
                if quizz.title == quizUsedTitle {
                    nextVC.quizz = quizz
                }
            }
        }
    }
}
