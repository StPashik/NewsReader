//
//  RequestManager.swift
//  NewsReader
//
//  Created by StPashik on 24.08.16.
//  Copyright © 2016 StDevelop. All rights reserved.
//

import UIKit
import Alamofire
import Kanna

extension Request {
    public func debugLog() -> Self {
        debugPrint(self)
        return self
    }
}

class RequestManager {

    class var sharedInstance: RequestManager {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: RequestManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = RequestManager()
        }
        return Static.instance!
    }
    
    private func basicRequestWithMethod(URLString: String, success: ((responseHTML: String!) -> Void)!, failure: ((error: NSError?) -> Void)!)
    {
        Alamofire.request(.GET, URLString)
            .validate(statusCode: 200..<300)
            .responseString { (responseString) in
                
                guard responseString.result.error == nil else {
                    failure(error: responseString.result.error!)
                    return
                    
                }
                guard let htmlAsString = responseString.result.value else {
                    
                    let userInfo: Dictionary<NSObject, AnyObject> = [
                        NSLocalizedFailureReasonErrorKey: "Could not get HTML as String",
                        Error.UserInfoKeys.StatusCode: Error.Code.StringSerializationFailed.rawValue
                    ]
                    
                    let error = NSError(domain: Error.Domain, code: Error.Code.StatusCodeValidationFailed.rawValue, userInfo: userInfo)
                    
                    failure(error: error)
                    return
                }
                
                success(responseHTML: htmlAsString)
        }
    }
}

// MARK: News requests
extension RequestManager {
    
    internal func getPosts(page: Int, success: ((responsePosts: [String]!) -> Void)!, failure: ((error: NSError?) -> Void)!)
    {
        let address = "http://4pda.ru/page/\(page)"
        
        basicRequestWithMethod(address, success: { (responseHTML) in
            
            if let doc = Kanna.HTML(html: responseHTML, encoding: NSUTF8StringEncoding) {
                let bodyNode = doc.body
                
                if let inputNodes = bodyNode?.xpath("//article[@class='post']") {
                    
                    var posts: Array<String> = []
                    
                    for node in inputNodes {
                        if node["itemscope"] == nil {
                            
                            posts.append(node.toHTML!)
                            
                        }
                    }
                    
                    success(responsePosts: posts)
                    
                }
            }
            
        }) { (error) in
            failure(error: error)
        }
    }
    
    internal func getPost(link: String, success: ((responseContent: String!) -> Void)!, failure: ((error: NSError?) -> Void)!)
    {
        basicRequestWithMethod(link, success: { (responseHTML) in
            
            if let doc = Kanna.HTML(html: responseHTML, encoding: NSUTF8StringEncoding) {
                let bodyNode = doc.body
                
                if let inputNodes = bodyNode?.xpath("//div[@class='content-box']/p") {
                    
                    var content: String = ""
                    
                    for node in inputNodes {
                        content += node.toHTML!
                    }
                    
                    success(responseContent: content)
                    
                }
            }
            
        }) { (error) in
            failure(error: error)
        }
    }
    
}