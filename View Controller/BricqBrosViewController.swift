//
//  BricqBrosViewController.swift
//  testYourself
//
//  Created by Arthur BRICQ on 08/02/2018.
//  Copyright © 2018 Arthur BRICQ. All rights reserved.
//

import UIKit

class BricqBrosViewController: UIViewController {

    
    @IBOutlet var globalView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTheBackground()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func updateTheBackground() {
        let gradient = CAGradientLayer()
        let beginningColor = UIColor(red: 73/255, green: 89/255, blue: 120/255, alpha: 1)
        let endColor = UIColor(red: 118/255, green: 132/255, blue: 208/255, alpha: 0.8)
        gradient.colors = [beginningColor.cgColor, endColor.cgColor]
        //gradient.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        gradient.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        globalView.layer.insertSublayer(gradient, at: 0)
    }
    

}
