//
//  UIColor+StLib.swift
//  Behterev
//
//  Created by StPashik on 20.04.15.
//  Copyright (c) 2015 Legion. All rights reserved.
//

import UIKit
import Foundation

extension UIColor {
    /**
    Получение UIColor по hex значению.
    
    :param: hex hex значение цвета.
    
    :returns: UIColor цвет.
    */
    class func colorWithHex(hex:UInt) -> UIColor
    {
        return self.colorWithHex(hex, alpha: 1)
    }
    
    /**
    Получение UIColor с alpha каналом по hex значению.
    
    :param: hex   hex значение цвета.
    :param: alpha Значение alpha канала.
    
    :returns: UIColor цвет с прозрачностью.
    */
    class func colorWithHex(hex:UInt, alpha:Float) -> UIColor
    {
        let red   = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0xFF00) >> 8) / 255.0
        let blue  = Double((hex & 0xFF)) / 255.0
        
        let color:UIColor = UIColor( red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha:CGFloat(alpha) )
        
        return color
    }
}