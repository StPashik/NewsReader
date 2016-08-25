//
//  BaseModel.swift
//  NewsReader
//
//  Created by StPashik on 24.08.16.
//  Copyright © 2016 StDevelop. All rights reserved.
//

import UIKit
import RealmSwift

class BaseModel: Object {
    
    internal func save(updated: Bool = false)
    {
        try! Realm().write({ () -> Void in
            try! Realm().add(self, update: updated)
        })
    }
    
    class func deleteAll()
    {
        try! Realm().write({ () -> Void in
            try! Realm().delete(try! Realm().objects(self))
        })
    }
    
}