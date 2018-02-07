//
//  customButton.swift
//  designableTest
//
//  Created by Arthur BRICQ on 07/02/2018.
//  Copyright © 2018 Arthur BRICQ. All rights reserved.
//

import UIKit

@IBDesignable class customButton: UIButton {
    
    // MARK : Variables
    @IBInspectable var cornerRadius : CGFloat = 3.0
    @IBInspectable var outerColor : UIColor = UIColor.red
    @IBInspectable var innerColor : UIColor = UIColor.gray
    @IBInspectable var lineWidth : CGFloat = 3.0
    
    
    
    override func draw(_ rect: CGRect)
    {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = lineWidth
        layer.borderColor = outerColor.cgColor
        
        if isThebuttonTapped {
            layer.backgroundColor = outerColor.cgColor
            titleLabel?.textColor = innerColor
        } else {
            layer.backgroundColor = innerColor.cgColor
            titleLabel?.textColor = outerColor
            
        }
        
    }
    
    var isThebuttonTapped : Bool = false {
        didSet {
            self.draw(layer.bounds)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isThebuttonTapped = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isThebuttonTapped = false
    }
}
