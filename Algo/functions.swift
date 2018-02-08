//
//  functions.swift
//  testYourself
//
//  Created by Marin on 08/02/2018.
//  Copyright © 2018 Arthur BRICQ. All rights reserved.
//

import Foundation
import UIKit

func norme(vector: CGVector) -> CGFloat {
    return sqrt((vector.dx)*(vector.dx) + (vector.dy)*(vector.dy))
}
func norme(vector: CGPoint) -> CGFloat {
    return sqrt((vector.x)*(vector.x) + (vector.y)*(vector.y))
}
