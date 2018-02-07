//
//  CustomButton_ToGo.swift
//  testYourself
//
//  Created by Arthur BRICQ on 07/02/2018.
//  Copyright © 2018 Arthur BRICQ. All rights reserved.
//

import UIKit

@IBDesignable  class CustomButton_ToGo: UIButton {

    @IBInspectable var outerColor  : UIColor = UIColor.red
    @IBInspectable var insideColor  : UIColor = UIColor.gray
    @IBInspectable var lineWidth : CGFloat = 3.0
    @IBInspectable var cornerRadius : CGFloat = 3.0
    
    override func draw(_ rect: CGRect) {
        
        let width = bounds.width
        let height = bounds.height
        
        let myRect = CGRect(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
        let rectPath = UIBezierPath(roundedRect: <#T##CGRect#>, cornerRadius: <#T##CGFloat#>)
    }
    

}
