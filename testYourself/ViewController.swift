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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func handlePan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        let screenCenter = self.view.center
        
        if let senderView = sender.view {
            if senderView.center.x + translation.x <= screenCenter.x {
                senderView.center.x = senderView.center.x + translation.x
            }
        
        
            if sender.state == UIGestureRecognizerState.ended {
                UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                    senderView.center.x = screenCenter.x
                }, completion: nil)
            }
        }
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    
    @IBAction func unwindToMenu(unwindSegue: UIStoryboardSegue){}
}

