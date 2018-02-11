//
//  customButton.swift
//  designableTest
//
//  Created by Arthur BRICQ on 07/02/2018.
//  Copyright © 2018 Arthur BRICQ. All rights reserved.
//

import UIKit

class customButton: UIButton {
    
    // MARK : Variables
    @IBInspectable var outerColor : UIColor = UIColor.red
    @IBInspectable var innerColor : UIColor = UIColor.gray
    
    @IBInspectable var lineWidth : CGFloat = 3.0
    @IBInspectable var cornerRadius : CGFloat = 3.0
    @IBInspectable var id : Int = 0
    
    override func draw(_ rect: CGRect)
    {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = lineWidth
        layer.borderColor = outerColor.cgColor
        layer.backgroundColor = innerColor.cgColor
        titleLabel?.textColor = outerColor
        
    }
    
    var isThebuttonTapped : Bool = false {
        didSet {
            if isThebuttonTapped {
                layer.backgroundColor = outerColor.cgColor
                titleLabel?.textColor = innerColor
            } else {
                layer.backgroundColor = innerColor.cgColor
                titleLabel?.textColor = outerColor
                
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
            self.layer.backgroundColor = self.outerColor.cgColor
            self.titleLabel?.textColor = self.innerColor
        }) { (tmp) in
            //
        }
        
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
            self.layer.backgroundColor = self.innerColor.cgColor
            self.titleLabel?.textColor = self.outerColor
        }) { (tmp) in
            //
        }
        
        super.touchesEnded(touches, with: event)
    }

}
