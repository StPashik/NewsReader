//
//  String+StLib.swift
//  Behterev
//
//  Created by StPashik on 20.04.15.
//  Copyright (c) 2015 Legion. All rights reserved.
//

import UIKit
import Foundation

extension String {
    
    var length: Int { return self.characters.count }
        
    /**
    Получение MD5 значение из текущей строки.
    
    :returns: Новая строка с MD5 значением от текущей.
    */
    public func MD5() -> String!
    {
        let str       = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen    = CUnsignedInt(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result    = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.destroy()
        
        return String(format: hash as String)
    }
    
    public func SHA1() -> String!
    {
        
        let data   = self.dataUsingEncoding(NSUTF8StringEncoding)!
        var digest = [UInt8](count:Int(CC_SHA1_DIGEST_LENGTH), repeatedValue: 0)
        
        CC_SHA1(data.bytes, CC_LONG(data.length), &digest)
        
        let output = NSMutableString(capacity: Int(CC_SHA1_DIGEST_LENGTH))
        
        for byte in digest {
            output.appendFormat("%02x", byte)
        }
        return output as String
        
    }
    
    public func notEmpty() -> Bool!
    {
        return (self != "")
    }
    
    public func stringRemovingSpaces() -> String!
    {
        return self.stringByReplacingOccurrencesOfString(" ", withString: "")
    }
    
    public func heightWithFont(font:UIFont, width:CGFloat) -> CGFloat
    {
        let text:NSString = self as NSString
        let height:CGFloat = text.boundingRectWithSize(CGSizeMake(width, CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName : font], context: nil).size.height
        
        return height
    }
    
    public func heightWithFontSize(fontSize:CGFloat,width:CGFloat) -> CGFloat!
    {
        let font = UIFont.systemFontOfSize(fontSize)
        let size = CGSizeMake(width,CGFloat.max)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .ByWordWrapping;
        
        let  attributes = [NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy()]
        
        let text = self as NSString
        let rect = text.boundingRectWithSize(size, options:.UsesLineFragmentOrigin, attributes: attributes, context:nil)
        
        return rect.size.height
    }
    
    public func heightWithFont(font:UIFont) -> CGFloat!
    {
        let text:NSString = self as NSString
        let height:CGFloat = ceil(text.sizeWithAttributes([NSFontAttributeName : font]).height)
        
        return height
    }
    
    public func wedthWithFont(font:UIFont) -> CGFloat!
    {
        let text:NSString = self as NSString
        let width:CGFloat = ceil(text.sizeWithAttributes([NSFontAttributeName : font]).width)
        
        return width
    }
    
    public func unformattedPhoneNumber() -> String!
    {
        var formatted:String? = nil
        let error:NSError? = nil
        
        let pattern:String! = "\\D"
        let regExp:NSRegularExpression = try! NSRegularExpression(pattern: pattern, options: [.CaseInsensitive])
        
        if (error != nil) {
            print("- UnformattedPhoneNumber error: \(error)")
        } else {
            formatted = regExp.stringByReplacingMatchesInString(self, options: .ReportProgress, range: NSMakeRange(0, self.length), withTemplate: "")
            formatted = "+\(stringByAppendingString(formatted!))"
        }
        
        return formatted
    }
    
    public func formatToDate(format: String?) -> NSDate
    {
        let isFormat:Bool = format != nil
        let dateFormatter: NSDateFormatter = NSDateFormatter.dateFormatterWithDateFormat(isFormat ? format! : "d.MM.yyyy")
        
        return dateFormatter.dateFromString(self)!
    }
    
    func stringByStrippingHTML() -> String
    {
        let regex : NSRegularExpression = try! NSRegularExpression(pattern:"<[^>]+>", options: NSRegularExpressionOptions.CaseInsensitive)
        let output = regex.stringByReplacingMatchesInString(self, options: NSMatchingOptions(), range: NSMakeRange(0, self.utf16.count), withTemplate: "")
        
        return output
    }
    
    public func replace(string:String, replacement:String) -> String {
        return self.stringByReplacingOccurrencesOfString(string, withString: replacement, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
    
    public func removeWhitespace() -> String {
        return self.replace(" ", replacement: "")
    }
    
    func removeCharsFromEnd(count_:Int) -> String {
        let stringLength = self.characters.count
        
        let substringIndex = (stringLength < count_) ? 0 : stringLength - count_
        
        return self.substringToIndex(self.startIndex.advancedBy(substringIndex))
    }
}

extension String {
    
    subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = startIndex.advancedBy(r.startIndex)
        let end = start.advancedBy(r.endIndex - r.startIndex)
        return self[Range(start ..< end)]
    }
}