//
//  NSDate+StLib.swift
//  Behterev
//
//  Created by StPashik on 20.04.15.
//  Copyright (c) 2015 Legion. All rights reserved.
//

import Foundation

extension NSDate
{
    public func isLaterThanOrEqualTo(date:NSDate) -> Bool
    {
        return self.compare(date) != NSComparisonResult.OrderedAscending
    }
    
    public func isEarlierThanOrEqualTo(date:NSDate) -> Bool
    {
        return self.compare(date) != NSComparisonResult.OrderedDescending
    }
    
    public func isLaterThan(date:NSDate) -> Bool
    {
        return self.compare(date) == NSComparisonResult.OrderedDescending
    }
    
    public func isEarlierThan(date:NSDate) -> Bool
    {
        return self.compare(date) == NSComparisonResult.OrderedAscending
    }
    
    public func withOutTime() -> NSDate
    {
        return NSDate(timeIntervalSinceReferenceDate: self.timeIntervalSinceReferenceDate / 86400 * 86400)
    }
    
    public func differenceFromDate(date:NSDate, interval:Int) -> Int
    {
        let secondsBetween: NSTimeInterval = self.timeIntervalSinceDate(date)
        let numberOfIntervals: Int = Int(secondsBetween) / interval
        
        return numberOfIntervals
    }
    
    public func afterDate(date:NSDate, dateFormat:String) -> String
    {
        let calendar: NSCalendar = NSCalendar.currentCalendar()
        
        let units: NSCalendarUnit = [NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year]
        let selfComponents: NSDateComponents = calendar.components(units, fromDate: self)
        let dateComponents: NSDateComponents = calendar.components(units, fromDate: date)
        
        let differenceDateComponents:NSDateComponents = calendar.components(NSCalendarUnit.Day, fromDate: calendar.dateFromComponents(dateComponents)!, toDate: calendar.dateFromComponents(selfComponents)!, options: NSCalendarOptions())
        
        var dateText:String
        
        switch (differenceDateComponents.day)
        {
        case -1:
            dateText = "Вчера"
            break
        case 0:
            dateText = "Сегодня"
            break
        case 1:
            dateText = "Завтра"
            break
            
        default:
            let dateFormatter:NSDateFormatter = NSDateFormatter.dateFormatterWithDateFormat(dateFormat)
            dateText = dateFormatter.stringFromDate(self)
            break
        }
        
        return dateText
    }

    public func formattedStringWithFormat(format:String?) -> String{
        let isFormat:Bool = format != nil
        let dateFormatter: NSDateFormatter = NSDateFormatter.dateFormatterWithDateFormat(isFormat ? format! : "d.MM.yyyy")
        
        return dateFormatter.stringFromDate(self)
    }

}
