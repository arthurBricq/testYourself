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
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        newTestView.center.x = self.view.center.x
        previousResultView.center.x = self.view.center.x
        moreAboutView.center.x = self.view.center.x
        counterToPerformSegueOnlyOnce = true // Variable is true when we can perform the segue. We need it because without it, the actions perfom thousands of segues.
    }
    
    
    // OUTLETS
    @IBOutlet weak var newTestView: UIView!
    @IBOutlet weak var previousResultView: UIView!
    @IBOutlet weak var moreAboutView: UIView!
    @IBOutlet weak var viewsWidth: NSLayoutConstraint!
    
    
    
    @IBAction func handlePan(_ sender: UIPanGestureRecognizer) {
        
        let screenCenter = self.view.center
        let pointLocation = sender.location(in: self.view)
        let senderView = sender.view!

        // Première fois que l'on touche l'écran, on appelle cette fonction
        if sender.state == UIGestureRecognizerState.began {
            boleanTestTMP = true
            origineX = pointLocation.x
            initialDiff = origineX - screenCenter.x
            print(initialDiff)
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
                    print("done \(senderView.center.x)")
                    UIView.animate(withDuration: 0.5, animations: {
                        print("sleeping.......")
                    }, completion: { (tmp) in
                        //self.performSegue(withIdentifier: "menuToNewTest", sender: self)
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

