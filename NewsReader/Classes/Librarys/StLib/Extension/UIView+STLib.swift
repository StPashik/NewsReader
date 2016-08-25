//
//  UIView+STLib.swift
//  Unimart
//
//  Created by StPashik on 26.02.16.
//  Copyright © 2016 StDevelop. All rights reserved.
//

import UIKit

extension UIView
{
    func copyView() -> AnyObject
    {
        return NSKeyedUnarchiver.unarchiveObjectWithData(NSKeyedArchiver.archivedDataWithRootObject(self))!
    }
}
