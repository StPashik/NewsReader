//
//  RoundedButton.swift
//  Unimart
//
//  Created by StPashik on 02.03.16.
//  Copyright © 2016 StDevelop. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = UIColor.clearColor() {
        didSet {
            layer.borderColor = borderColor.CGColor
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }

}
