//
//  PreviousResultViewController.swift
//  testYourself
//
//  Created by Marin on 10/02/2018.
//  Copyright © 2018 Arthur BRICQ. All rights reserved.
//

import UIKit

class PreviousResultViewController: UIViewController {
    
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

}
