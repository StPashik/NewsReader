//
//  News.swift
//  NewsReader
//
//  Created by StPashik on 24.08.16.
//  Copyright © 2016 StDevelop. All rights reserved.
//

import UIKit
import RealmSwift
import Kanna

class Post: BaseModel {
    
    dynamic var serverID = 0
    dynamic var title    = ""
    dynamic var descript = ""
    dynamic var content  = ""
    dynamic var image    = ""
    dynamic var link     = ""
    dynamic var comments = 0
    dynamic var date     = NSDate(timeIntervalSince1970: 1)
    
    //MARK: - Realm override
    override static func primaryKey() -> String {
        return "serverID"
    }
    
    //MARK: - init
    convenience init(info: String) {
        self.init()
        
        if let doc = Kanna.HTML(html: info, encoding: NSUTF8StringEncoding) {
            
            title    = (doc.at_xpath("//div[@class='description']/h1")?.text)!
            descript = (doc.at_xpath("//div[@itemprop='description']/p")?.text)!
            link     = (doc.at_xpath("//div[@class='description']/h1/a")?["href"])!
            image    = (doc.at_xpath("//div[@class='visual']/a/img")?["src"])!

            date     = (doc.at_xpath("//meta[@itemprop='datePublished']")?["content"]!.formatToDate("yyyy-MM-dd'T'HH:mm:ssxxx"))!
            comments = Int((doc.at_xpath("//div[@class='v-panel']/a")?.text)!)!
            
            let linkSeparate = link.componentsSeparatedByString("/")
            
            if linkSeparate.indexOf("special") == nil {
                serverID = Int(linkSeparate[linkSeparate.count - 2])!
                
                if let oldPost = existingPost(serverID) {
                    content = oldPost.content
                }
            }
        }
    }
    
    class func getAllPosts(page: Int, refresh: Bool = false, complete: (() -> Void)!)
    {
        RequestManager.sharedInstance.getPosts(page, success: { (responsePosts) in
            
            for info in responsePosts {
                let post = Post(info: info)
                post.save(true)
            }
            
            defer { complete() }
            
        }, failure: nil)
    }
    
    internal func getPostContent(complete: ((content: String) -> Void)!)
    {
        RequestManager.sharedInstance.getPost(link, success: { (responseContent) in
            
            try! Realm().write({ 
                self.content = responseContent
            })
            
            defer { complete(content: self.content) }
            
        }, failure: nil)
    }
    
    private func existingPost(serverID: Int) -> Post?
    {
        if let post = try! Realm().objectForPrimaryKey(Post.self, key: serverID) {
            return post
        } else {
            return nil
        }
    }

}
