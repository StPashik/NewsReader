//
//  Results+STLib.swift
//  Unimart
//
//  Created by StPashik on 19.02.16.
//  Copyright © 2016 StDevelop. All rights reserved.
//

import UIKit
import RealmSwift

extension Results {
    
    var list:List<T> {
        let results: Results<T> = self
        let converted = results.reduce(List<T>()) { (list, element) -> List<T> in
            list.append(element)
            return list
        }
        
        return converted
    }
    
}
