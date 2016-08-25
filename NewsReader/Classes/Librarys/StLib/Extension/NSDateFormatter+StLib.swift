//
//  NSDateFormatter+StLib.swift
//  Behterev
//
//  Created by StPashik on 20.04.15.
//  Copyright (c) 2015 Legion. All rights reserved.
//

import Foundation

extension NSDateFormatter
{
    static func dateFormatterWithDateFormat(aDateFormat:String) -> NSDateFormatter
    {
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = aDateFormat
        
        return dateFormatter
    }
}