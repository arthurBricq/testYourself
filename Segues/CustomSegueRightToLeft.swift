//
//  CustomSegueRightToLeft.swift
//  testYourself
//
//  Created by Marin on 04/02/2018.
//  Copyright © 2018 Arthur BRICQ. All rights reserved.
//

import UIKit

class CustomSegueRightToLeft: UIStoryboardSegue {
    override func perform() {
        
        // crée la vue source et celle de destination
        let sourceView = self.source.view as UIView!
        let destinationView = self.destination.view as UIView!
        
        /*let source = self.source as! ViewController
        source.newTestView.center.x = -1000
        let sourceView = source.view*/
        
        // recupere la hauteur et la largeur de l'écran
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        // place la view de destination à droite de l'écran
        destinationView?.frame = CGRect(x: screenWidth, y: 0, width: screenWidth, height: screenHeight)
        
        // ajoute la destination à l'écran de l'app au-dessus de la vue d'origine
        let window = UIApplication.shared.keyWindow
        window?.insertSubview(destinationView!, aboveSubview: sourceView!)
        
        UIView.animate(withDuration: 1.5, delay: 0, options: [], animations: {
            sourceView?.frame = CGRect(x: -screenWidth, y: 0, width: screenWidth, height: screenHeight)
            destinationView?.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
            
        }) {(Finished) in
            self.source.present(self.destination as UIViewController, animated: false, completion: nil)
            sourceView?.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
            print("the view is changed.")
        }
    }
}
