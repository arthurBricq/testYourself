//
//  ViewController.swift
//  testYourself
//
//  Created by Arthur BRICQ on 02/02/2018.
//  Copyright © 2018 Arthur BRICQ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewsWidth.constant = self.view.frame.width
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        counterToPerformSegueOnlyOnce = true // Variable is true when we can perform the segue. We need it because without it, the actions perfom thousands of segues.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // OUTLETS
    @IBOutlet weak var startView: UIView!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var viewsWidth: NSLayoutConstraint!
    
    
    
    @IBAction func handlePan(_ sender: UIPanGestureRecognizer) {
        
        let screenCenter = self.view.center
        let pointLocation = sender.location(in: self.view)
        let senderView = sender.view!

        // Première fois que l'on touche l'écran, on appelle cette fonction
        if sender.state == UIGestureRecognizerState.began {
            boleanTestTMP = true
            initialDiff = pointLocation.x - screenCenter.x
            print("initialDiff = \(initialDiff)")
        }
        
        if boleanTestTMP == true { // Actualisation de la valeur si le test bouléin le permet.
            senderView.center.x = pointLocation.x - initialDiff
            xPos = senderView.center.x
        }
        
        if senderView.center.x > screenCenter.x { // Si on retourne vers la droite, bloquer le mouvement.
            senderView.center.x = screenCenter.x
        }
            
        if xPos < -50 // Si on termine le mouvement...
        {
            if counterToPerformSegueOnlyOnce {
                boleanTestTMP = false
                print("Segue now")
                counterToPerformSegueOnlyOnce = false

                UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut, animations: {
                    senderView.center.x = -screenCenter.x
                }, completion: { (tmp) in
                    
                    print("Before sleep : \(senderView.center.x)")
                    
                    UIView.animate(withDuration: 0.5, animations: {
                        print("sleeping.......")
                    }, completion: { (tmp) in
                        
                        var segueId = "VCToQuizzVC"
                        
                        if sender.view == self.startView {
                            segueId = "VCToQuizzVC"
                            whichViewIsChanging = 1
                        } else if sender.view == self.resultView {
                            segueId = "VCToPreviousResultVC"
                            whichViewIsChanging = 2
                        } else if sender.view == self.bottomView {
                            segueId = "VCToMoreAboutUs"
                            whichViewIsChanging = 3
                        }
                        
                        self.performSegue(withIdentifier: segueId, sender: self)
                    })
                })
            }
        }
        
        if boleanTestTMP {
            if sender.state == UIGestureRecognizerState.ended
            {
                print("going back to inital position")
                counterToPerformSegueOnlyOnce = true
                UIView.animate(withDuration: 0.5,delay : 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    senderView.center.x = screenCenter.x
                })
            }
        }
        
    }
    
    @IBAction func unwindToMenu(unwindSegue: UIStoryboardSegue){}
}

