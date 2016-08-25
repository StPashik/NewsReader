//
//  UIImage+StLib.swift
//  Behterev
//
//  Created by StPashik on 20.04.15.
//  Copyright (c) 2015 Legion. All rights reserved.
//

import UIKit
import Foundation

extension UIImage {
    class func imageWithColor(color:UIColor, size:CGSize) -> UIImage!
    {
        let rect:CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        let contex:CGContextRef = UIGraphicsGetCurrentContext()!
        CGContextSetFillColorWithColor(contex, color.CGColor)
        CGContextFillRect(contex, rect)
        
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        return image
    }
    
    class func roundedImageWithFillColor(fillColor:UIColor, borderColor:UIColor, size:CGSize, border:CGFloat) -> UIImage
    {
        let rect:CGRect = CGRectMake(0, 0, (size.width + border), (size.height + border))
        let widthWithBorder:Float = Float(rect.size.width / 2)
        let heightWithBorder:Float = Float(rect.size.height / 2)
        let radius:Float = minValue([widthWithBorder, heightWithBorder])!
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.mainScreen().scale)
        
        borderColor.setStroke()
        fillColor.setFill()
        
        let borderPath:UIBezierPath = UIBezierPath(roundedRect:rect, cornerRadius:CGFloat(radius))
        borderPath.lineWidth = border
        borderPath.addClip()
        borderPath.fill()
        borderPath.stroke()
        
        let roundedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return roundedImage
    }
    
    public func coloredImageWithColor(color:UIColor) -> UIImage!
    {
        let rect:CGRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, self.scale)
        let context:CGContextRef = UIGraphicsGetCurrentContext()!
        
        self.drawInRect(rect)
        
        color.set()
        CGContextClipToMask(context, rect, self.CGImage)
        CGContextFillRect(context, rect)
        
        let coloredImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return coloredImage
    }
}