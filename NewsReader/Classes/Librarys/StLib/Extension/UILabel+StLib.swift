//
//  UILabel+StLib.swift
//  Behterev
//
//  Created by StPashik on 20.04.15.
//  Copyright (c) 2015 Legion. All rights reserved.
//

import UIKit
import Foundation

extension UILabel {
    public func startAnimationOfValidation()
    {
        let defaultTextColor:UIColor = self.textColor
        if (defaultTextColor == kSTLibValidationErrorColor) { return }
        
        UIView.transitionWithView(self, duration: 0.6, options: .TransitionCrossDissolve, animations: { () -> Void in
            self.textColor = kSTLibValidationErrorColor
            }) { (finished:Bool) -> Void in
                if finished {
                    UIView.transitionWithView(self, duration: 0.6, options: .TransitionCrossDissolve, animations: { () -> Void in
                        self.textColor = defaultTextColor
                        }, completion: nil)
                }
        }
    }
}

extension UILabel
{
    public func optimalHeight(maxHeight: CGFloat = CGFloat.max, width: CGFloat) -> CGFloat
    {
        let label = UILabel(frame: CGRectMake(0, 0, width, maxHeight))
        label.numberOfLines = 0
        label.lineBreakMode = self.lineBreakMode
        label.font = self.font
        label.text = self.text
        
        label.sizeToFit()
        
        return label.frame.height
    }
    
    public func optimalHeight(maxHeight: CGFloat = CGFloat.max) -> CGFloat
    {
        let label = UILabel(frame: CGRectMake(0, 0, self.frame.width, maxHeight))
        label.numberOfLines = 0
        label.lineBreakMode = self.lineBreakMode
        label.font = self.font
        label.text = self.text
        
        label.sizeToFit()
        
        return label.frame.height
    }
    
    public func optimalWidth(maxWidth: CGFloat = CGFloat.max) -> CGFloat
    {
        let label = UILabel(frame: CGRectMake(0, 0, maxWidth, self.frame.height))
        label.numberOfLines = 0
        label.lineBreakMode = self.lineBreakMode
        label.font = self.font
        label.text = self.text
        
        label.sizeToFit()
        
        return label.frame.width
    }
}