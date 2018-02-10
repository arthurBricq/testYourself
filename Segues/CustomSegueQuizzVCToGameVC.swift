//
//  CustomSegueQuizzVCToGameVC.swift
//  testYourself
//
//  Created by Marin on 10/02/2018.
//  Copyright © 2018 Arthur BRICQ. All rights reserved.
//

import UIKit

class CustomSegueQuizzVCToGameVC: UIStoryboardSegue {
    override func perform() {
        
        // recupere la fenetre de l'écran
        let window = UIApplication.shared.keyWindow
        
        // recupere la vue source et celle de destination
        let source = self.source
        let destination = self.destination
        let sourceView = source.view
        let destinationView = destination.view
        
        // recupere la hauteur et la largeur de l'écran
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        // place la view de destination à droite de l'écran
        destinationView?.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        
        // ajoute la destination à l'écran de l'app au-dessus de la vue d'origine
        window?.insertSubview(destinationView!, belowSubview: sourceView!)
        
        UIView.transition(from: sourceView!, to: destinationView!, duration: 1, options: [.curveEaseOut, .transitionFlipFromRight]) { (tmp) in
            source.present(destination, animated: false, completion: nil)
        }
    }
}
