//
//  CustomButtonForTheQuizzMenu.swift
//  testYourself
//
//  Created by Marin on 06/02/2018.
//  Copyright © 2018 Arthur BRICQ. All rights reserved.
//

import UIKit

class CustomButtonForTheQuizzMenu: UIButton {
    
    @IBInspectable var fillColor : UIColor = UIColor.blue
    @IBInspectable var cornerRadius : CGFloat = 5
    
    override func draw(_ rect: CGRect)
    {
        // Drawing code
        
        let width = bounds.width
        let height = bounds.height
        fillColor.setFill()
        
        let rectPath = UIBezierPath(roundedRect: CGRect(x: 0.2*width, y: 0.1*height, width: 0.7*width, height: 0.8*height), byRoundingCorners: [UIRectCorner.topRight, UIRectCorner.bottomRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        
        rectPath.fill()
        
        let arrowPath = UIBezierPath()
        arrowPath.move(to: CGPoint(x: 0.20*width, y: 0.1*height))
        arrowPath.addLine(to: CGPoint(x: 0, y: height/2))
        arrowPath.addLine(to: CGPoint(x: 0.20*width, y: 0.9*height))
        arrowPath.addLine(to: CGPoint(x: 0.20*width+1, y: 0.9*height))
        arrowPath.addLine(to: CGPoint(x: 0.20*width+1, y: 0.1*height))
        arrowPath.fill()
        
    }

    
}
