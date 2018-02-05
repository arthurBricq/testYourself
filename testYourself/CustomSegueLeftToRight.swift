//
//  CustomSegueLeftToRight.swift
//  testYourself
//
//  Created by Marin on 04/02/2018.
//  Copyright © 2018 Arthur BRICQ. All rights reserved.
//

import UIKit

class CustomSegueLeftToRight: UIStoryboardSegue {
    override func perform() {
        
        // recupere la fenetre de l'écran
        let window = UIApplication.shared.keyWindow
        
        // crée la vue source et celle de destination
        let sourceView = self.source.view
        let destinationView = self.destination.view
        
        // recupere la hauteur et la largeur de l'écran
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        // place la view de destination à droite de l'écran
        destinationView?.frame = CGRect(x: -screenWidth, y: 0, width: screenWidth, height: screenHeight)
        
        // ajoute la destination à l'écran de l'app au-dessus de la vue d'origine
        window?.insertSubview(destinationView!, aboveSubview: sourceView!)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            sourceView?.frame = CGRect(x: screenWidth, y: 0, width: screenWidth, height: screenHeight)
            destinationView?.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        }, completion: {(finished: Bool) in
            self.source.present(self.destination, animated: false, completion: nil)
        })
    }
}
