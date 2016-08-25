//
//  PostController.swift
//  NewsReader
//
//  Created by StPashik on 24.08.16.
//  Copyright © 2016 StDevelop. All rights reserved.
//

import UIKit
import LGPlaceholderView

class PostController: UIViewController, UIWebViewDelegate, PostSelectionDelegate {
    
    private var placeholderView: LGPlaceholderView!
    private var allowLoad = true
    
    private var contentLoad: (() -> Void)!
    
    @IBOutlet weak var contentView: UIWebView!
    
    var post: Post! {
        didSet (newPost) {
            
            if !IS_IPHONE {
                loadPostContent()
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placeholderView = LGPlaceholderView(view: contentView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if post != nil {
            loadPostContent()
        }
    }
    
    //MARK: - PostSelectionDelegate
    
    func postSelected(newPost: Post) {
        post = newPost
    }
    
    func reloadCellChash(complete: () -> Void) {
        contentLoad = complete
    }
    
    //MARK: - UIWebViewDelegate
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool
    {
        return allowLoad
    }
    
    func webViewDidFinishLoad(webView: UIWebView)
    {
        allowLoad = false
        placeholderView.dismissAnimated(true, completionHandler: nil)
    }
    
    //MARK: - Private methods
    
    private func refreshInterface()
    {
        allowLoad = true
        contentView.loadHTMLString(post.content, baseURL: nil)
    }
    
    private func loadPostContent()
    {
        placeholderView.showActivityIndicatorAnimated(false, completionHandler: nil)
        
        if post.content == "" {
            
            post.getPostContent { (content) in
                
                self.contentLoad()
                self.refreshInterface()
                
            }
        } else {
            refreshInterface()
        }
    }

}
