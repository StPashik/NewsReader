//
//  UITextField+StLib.swift
//  Behterev
//
//  Created by StPashik on 20.04.15.
//  Copyright (c) 2015 Legion. All rights reserved.
//

import UIKit
import Foundation

extension UITextField
{
    public func setLeftPadding(padding:CGFloat)
    {
        let paddingView: UIView = UIView(frame: CGRectMake(CGFloat(0), CGFloat(0), padding, CGFloat(self.frame.size.height)))
        self.leftView = paddingView
        self.leftViewMode = .Always
    }
    
    public func isValid() -> Bool
    {
        let emty           = self.text != nil && self.text != ""
        let notPlaceholder = self.text != self.placeholder
        
        return emty && notPlaceholder
    }
    
    public func validateWithAnimation() -> Bool
    {
        if (isValid())
        {
            return true
        }
        
        startValidationAnimation()
        
        return false
    }
    
    public func startValidationAnimation()
    {
        let color = CABasicAnimation(keyPath: "borderColor")
        
        color.fromValue = UIColor.lightGrayColor().CGColor
        color.toValue = UIColor.redColor().CGColor
        color.duration = 0.25
        color.repeatCount = 1
        self.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.layer.addAnimation(color, forKey: "borderColor")
    }
    
    public func isValidEmail() -> Bool
    {
        let regex = try! NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$", options: [.CaseInsensitive])
        return regex.firstMatchInString(self.text!, options: [], range: NSMakeRange(0, self.text!.length)) != nil
    }
    
    public func formatPhoneNumber(shouldAttempt: Bool)
    {
        if !shouldAttempt {
            return
        }
        
        let currentValue: NSString = self.text!
        var strippedValue: NSString = currentValue.stringByReplacingOccurrencesOfString("[^0-9]", withString: "", options: .RegularExpressionSearch, range: NSMakeRange(0, currentValue.length))
        strippedValue = strippedValue.length <= 1 ? strippedValue : strippedValue.substringFromIndex(1)
        var formattedString: NSString = ""
        
        if strippedValue.length == 0 {
            formattedString = "";
        }
        else if strippedValue.length < 3 {
            formattedString = "+7 (" + (strippedValue as String)
        }
        else if strippedValue.length == 3 {
            formattedString = "+7 (" + (strippedValue as String) + ") "
        }
        else if strippedValue.length < 6 {
            formattedString = "+7 (" + strippedValue.substringToIndex(3) + ") " + strippedValue.substringFromIndex(3)
        }
        else if strippedValue.length == 6 {
            formattedString = "+7 (" + strippedValue.substringToIndex(3) + ") " + strippedValue.substringFromIndex(3) + "-"
        }
        else if strippedValue.length < 8 {
            formattedString = "+7 (" + strippedValue.substringToIndex(3) + ") " + strippedValue.substringWithRange(NSMakeRange(3, 3)) + "-" + strippedValue.substringFromIndex(6)
        }
        else if strippedValue.length == 8 {
            formattedString = "+7 (" + strippedValue.substringToIndex(3) + ") " + strippedValue.substringWithRange(NSMakeRange(3, 3)) + "-" + strippedValue.substringWithRange(NSMakeRange(6, 2)) + "-"
        }
        else if strippedValue.length <= 10 {
            formattedString = "+7 (" + strippedValue.substringToIndex(3) + ") " + strippedValue.substringWithRange(NSMakeRange(3, 3)) + "-" + strippedValue.substringWithRange(NSMakeRange(6, 2)) + "-" + strippedValue.substringFromIndex(8)
        }
        else if strippedValue.length >= 11 {
            formattedString = "+7 (" + strippedValue.substringToIndex(3) + ") " + strippedValue.substringWithRange(NSMakeRange(3, 3)) + "-" + strippedValue.substringWithRange(NSMakeRange(6, 2)) + "-" + strippedValue.substringWithRange(NSMakeRange(8, 2))
        }
        
        self.text = formattedString as String
    }
}