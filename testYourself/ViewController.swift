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
    }
    
    override func viewWillAppear(_ animated: Bool) {
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

    @IBAction func handlePan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        let screenCenter = self.view.center
        
        if let senderView = sender.view {
            if senderView.center.x + translation.x <= screenCenter.x {
                senderView.center.x = senderView.center.x + translation.x
            }
        
        
            if sender.state == UIGestureRecognizerState.ended {
                if senderView.center.x >= 0 {
                    UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                        senderView.center.x = screenCenter.x
                    }, completion: nil)
                }
            }
            
            if senderView.center.x < 0 {
                UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    senderView.center.x = -screenCenter.x
                }, completion: { (finished: Bool) in
                    if counterToPerformSegueOnlyOnce {
                        counterToPerformSegueOnlyOnce = false
                        self.performSegue(withIdentifier: "menuToNewTest", sender: self)
                    }
                })
            }
        }
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    @IBAction func unwindToMenu(unwindSegue: UIStoryboardSegue){}
}

