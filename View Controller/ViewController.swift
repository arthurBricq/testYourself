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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        counterToPerformSegueOnlyOnce = true // Variable is true when we can perform the segue. We need it because without it, the actions perfom thousands of segues.
        // On remet à zero toutes les données du jeu.
        score = [0,0,0,0,0,0]
        initialize_OneQuizzChecked()
        activeQuestionIdentifier = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isItTheFirstTimeTheViewAppear { // We want to do the animation only once.
            animateTheView()
        }
        
        // On charge les anciens résultats:
        allScores = loadFromFile()

    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // OUTLETS
    @IBOutlet weak var startView: UIView!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var titleView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var finalView: UIView!
    @IBOutlet weak var topView: UIView!
    // Constraints for the initial animation:
    @IBOutlet weak var topViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var startViewCenterX: NSLayoutConstraint!
    @IBOutlet weak var resultViewLeading: NSLayoutConstraint!
    @IBOutlet weak var bottomViewLeading: NSLayoutConstraint!
    @IBOutlet weak var finalViewLeading: NSLayoutConstraint!
    @IBOutlet weak var upperConstraint: NSLayoutConstraint!
    
    
    
    func animateTheView()
    {
        // First, we give the view the initial position that we wanna have.
        prepareForAnimation()
        self.view.layoutIfNeeded()
        isItTheFirstTimeTheViewAppear = false
        
        UIView.animate(withDuration: 0.8, delay: 0, options: [.curveEaseInOut, .allowAnimatedContent], animations: {
            // First animation : making appear the 'Test Yourself Label''
            self.upperConstraint.constant = 60
            self.view.layoutIfNeeded()
            
        }) { (tmp1) in
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut, animations: {
                // Second animation : making appear the startView
                self.startViewCenterX.constant = 0
                self.view.layoutIfNeeded()

            }, completion: { (tmp2) in
                UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseInOut, animations: {
                    //Thir animation : making appear the resultView
                    self.resultViewLeading.constant = 0
                    self.view.layoutIfNeeded()

                }, completion: { (tmp3) in
                    UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseInOut, animations: {
                        self.bottomViewLeading.constant = 0
                        self.view.layoutIfNeeded()
                        
                    }, completion: { (tmp4) in
                        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                            self.finalViewLeading.constant = 0
                            self.view.layoutIfNeeded()

                        }, completion: { (tmp5) in
                            //
                        })
                    })
                })
                
                
            })
        }
        
    }
    
    func prepareForAnimation() {
        // First: making everything away
        let screenWidth = self.view.bounds.width
        print(screenWidth)
        let topViewHeight = topView.bounds.height
        print(topViewHeight)
        startViewCenterX.constant = -screenWidth
        resultViewLeading.constant = -2*screenWidth
        bottomViewLeading.constant = -2*screenWidth
        finalViewLeading.constant = -2*screenWidth
        // topViewTopConstraint.constant = -topViewHeight
        upperConstraint.constant = -250
    }
    
    // MARK : Pan Gesture function 
    
    @IBAction func handlePan(_ sender: UIPanGestureRecognizer) {
        
        let screenCenter = self.view.center
        let pointLocation = sender.location(in: self.view)
        let senderView = sender.view!

        // Première fois que l'on touche l'écran, on appelle cette fonction
        if sender.state == UIGestureRecognizerState.began {
            boleanTestTMP = true
            initialDiff = pointLocation.x - screenCenter.x
        }
        
        if boleanTestTMP == true { // Actualisation de la valeur si le test bouléin le permet.
            senderView.center.x = pointLocation.x - initialDiff
            xPos = senderView.center.x
        }
        
        if senderView.center.x > screenCenter.x { // Si on retourne vers la droite, bloquer le mouvement.
            senderView.center.x = screenCenter.x
        }
        
        let velocity = sender.velocity(in: self.view)
        let speed = norme(vector: velocity)
        if (xPos < -50) || (speed > 1999) // Si on termine le mouvement...
        {
            if counterToPerformSegueOnlyOnce {
                boleanTestTMP = false
                counterToPerformSegueOnlyOnce = false

                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                    senderView.center.x = -screenCenter.x
                }, completion: { (tmp) in
                    
                    UIView.animate(withDuration: 0.3, animations: {
                       // print("sleeping.......")
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

