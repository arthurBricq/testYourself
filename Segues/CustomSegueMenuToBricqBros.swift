//
//  CustomSegueMenuToBricqBros.swift
//  testYourself
//
//  Created by Marin on 09/02/2018.
//  Copyright © 2018 Arthur BRICQ. All rights reserved.
//

import UIKit

import UIKit

class CustomSegueMenuToBricqBros: UIStoryboardSegue {
    override func perform() {
        
        isInSegueFromMenuToBricqBros = true
        
        // recupere la fenetre de l'écran
        let window = UIApplication.shared.keyWindow
        
        // recupere les VC source et de destination et leur vue
        let source = self.source as! ViewController
        let destination = self.destination as! BricqBrosViewController
        let sourceView = source.view
        let destinationView = destination.view
        
        // recupere la hauteur et la largeur de l'écran
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        // place la view de destination à droite de l'écran
        destinationView?.frame = CGRect(x: 0, y: screenHeight, width: screenWidth, height: screenHeight)
        
        // ajoute la destination à l'écran de l'app au-dessus de la vue d'origine
        window?.insertSubview(destinationView!, aboveSubview: sourceView!)
        
        destination.bricqLabel.isHidden = true
        destination.brosLabel.isHidden = true
        
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: .calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0, animations: {
                source.bottomView.center.x = -screenWidth
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
                source.resultView.center.x = -screenWidth
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.25, animations: {
                source.startView.center.x = -screenWidth
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.45, relativeDuration: 0.55, animations: {
                sourceView?.frame = CGRect(x: 0, y: -screenHeight, width: screenWidth, height: screenHeight)
                destinationView?.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
            })
            
        }) { (finished) in
            source.present(self.destination, animated: false, completion: nil)
            isInSegueFromMenuToBricqBros = false
        }
    }
}
