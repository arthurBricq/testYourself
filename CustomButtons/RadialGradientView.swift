//
//  RadialGradientView.swift
//  testYourself
//
//  Created by Marin on 09/02/2018.
//  Copyright © 2018 Arthur BRICQ. All rights reserved.
//

import UIKit

@IBDesignable class RadialGradientView: UIView {
    
    @IBInspectable var outsideColor : UIColor = UIColor.red
    @IBInspectable var insideColor : UIColor = UIColor.blue
    @IBInspectable var firstColorCircleRadius : CGFloat = 0
    @IBInspectable var rectangleCornerRadius : CGFloat = 0
    
    override func draw(_ rect: CGRect) {
        
        // crée un dégradé radial
        let colors = [insideColor.cgColor, outsideColor.cgColor] as CFArray
        let endRadius = sqrt(pow(frame.width/2, 2) + pow(frame.height/2, 2))
        let center = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        let gradient = CGGradient(colorsSpace: nil, colors: colors, locations: nil)
        
        // cree un rectangle avec des angles arrondi et le met comme fond pour le contexte
        let path = UIBezierPath(roundedRect: rect, cornerRadius: rectangleCornerRadius)
        path.addClip()
        
        // dessine le dégradé
        let context = UIGraphicsGetCurrentContext()!
        context.drawRadialGradient(gradient!, startCenter: center, startRadius: firstColorCircleRadius, endCenter: center, endRadius: endRadius, options: .drawsBeforeStartLocation)
    }
    
}
