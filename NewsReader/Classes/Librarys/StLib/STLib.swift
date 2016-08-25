//
//  STLib.swift
//  KidsMusic
//
//  Created by StPashik on 26.12.14.
//  Copyright (c) 2014 StPashik. All rights reserved.
//

import UIKit
import Foundation

let IS_IPAD             = (UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad)
let IS_IPHONE           = (UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone)
let IS_RETINA           = (UIScreen.mainScreen().scale >= 2.0)
let IS_LANDSCAPE        = UIDevice.currentDevice().orientation.isLandscape

let SCREEN_WIDTH        = (UIScreen.mainScreen().bounds.size.width)
let SCREEN_HEIGHT       = (UIScreen.mainScreen().bounds.size.height)
let SCREEN_MAX_LENGTH   = (maxValue([SCREEN_WIDTH, SCREEN_HEIGHT]))
let SCREEN_MIN_LENGTH   = (minValue([SCREEN_WIDTH, SCREEN_HEIGHT]))

let IS_IPHONE_4_OR_LESS = (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
let IS_IPHONE_5         = (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
let IS_IPHONE_6         = (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
let IS_IPHONE_6_PLUS    = (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

func SYSTEM_VERSION_EQUAL_TO(v:String) -> Bool { return (UIDevice.currentDevice().systemVersion.compare(v, options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedSame) }
func SYSTEM_VERSION_GREATER_THAN(v:String) -> Bool { return (UIDevice.currentDevice().systemVersion.compare(v, options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedDescending) }
func SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v:String) -> Bool { return (UIDevice.currentDevice().systemVersion.compare(v, options: NSStringCompareOptions.NumericSearch) != NSComparisonResult.OrderedAscending) }
func SYSTEM_VERSION_LESS_THAN(v:String) -> Bool { return (UIDevice.currentDevice().systemVersion.compare(v, options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedAscending) }
func SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v:String) -> Bool { return (UIDevice.currentDevice().systemVersion.compare(v, options: NSStringCompareOptions.NumericSearch) != NSComparisonResult.OrderedDescending) }

let IOS_9_OR_LATER:Bool                = SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO("9.0")
let IOS_8_OR_LATER:Bool                = SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO("8.0")
let IOS_7_OR_LATER:Bool                = SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO("7.0")

let kSTLibValidationErrorColor:UIColor = UIColor.colorWithHex(0xEE4831)

let kSTLibNumberOfDaysInWeek:Float     = 7

struct TimeInterval {
    static var Minute   :Int {get {return 60}}
    static var Hour     :Int {get {return 3600}}
    static var Day      :Int {get {return 86400}}
    static var Week     :Int {get {return 604800}}
}

func minValue <T : Comparable> (array : [T]) -> T? {
    if array.isEmpty { return nil }
    return array.reduce(array[0]) {$0 > $1 ? $1 : $0}
}

func maxValue <T : Comparable> (array : [T]) -> T? {
    if array.isEmpty { return nil }
    return array.reduce(array[0]) {$0 < $1 ? $1 : $0}
}

func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}









