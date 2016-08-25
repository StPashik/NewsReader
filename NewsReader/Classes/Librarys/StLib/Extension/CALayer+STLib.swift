//
//  CALayer+STLib.swift
//  gazpromsoc
//
//  Created by StPashik on 10.05.16.
//  Copyright © 2016 StDevelop. All rights reserved.
//

import UIKit

extension CALayer {
    func borderUIColor() -> UIColor? {
        return borderColor != nil ? UIColor(CGColor: borderColor!) : nil
    }
    
    func setBorderUIColor(color: UIColor) {
        borderColor = color.CGColor
    }
}
