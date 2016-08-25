//
//  Constants.swift
//  NewsReader
//
//  Created by StPashik on 24.08.16.
//  Copyright © 2016 StDevelop. All rights reserved.
//

import UIKit

enum Categorys {
    case Empty
    case News
    case Articles
    case Software
    case Games
    
    static let names = ["Новости","Статьи","Софт","Игры"]
    
    var description : String {
        get {
            switch(self) {
                case Empty:
                    return ""
                case News:
                    return "news/"
                case Articles:
                    return "articles/"
                case Software:
                    return "software/"
                case Games:
                    return "games/"
            }
        }
    }
}