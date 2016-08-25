//
//  Float+StLib.swift
//  pfizercalc
//
//  Created by StPashik on 17.12.15.
//  Copyright © 2015 legion. All rights reserved.
//

import UIKit

extension Float {
    var asLocaleCurrency:String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale.currentLocale()
        return formatter.stringFromNumber(self)!
    }
}