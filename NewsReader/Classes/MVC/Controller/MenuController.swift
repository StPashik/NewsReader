//
//  MenuController.swift
//  NewsReader
//
//  Created by StPashik on 24.08.16.
//  Copyright © 2016 StDevelop. All rights reserved.
//

import UIKit
import RealmSwift

protocol PostSelectionDelegate: class {
    func postSelected(newMonster: Post)
    func reloadCellChash(complete: () -> Void)
}

class MenuController: UITableViewController {
    
    weak var delegate: PostSelectionDelegate?
    
    private var posts = List<Post>()
    private var loadingOffsetMarker: Int?
    
    private let productPerPage = 30

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl!.addTarget(self, action: #selector(refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        refreshControl?.beginRefreshing()
        
        self.posts = try! Realm().objects(Post).sorted("date", ascending: false).list
        
        self.refresh(refreshControl!)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return posts.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let marker = NSObject()
        
        let identifier = (indexPath.row%5) == 0 ? "BigPostCell" : "SmallPostCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! PostCell
        
        cell.post = posts[indexPath.row]
        cell.marker = marker
        
        let imageView = UIImageView()
        let imageStringURL = posts[indexPath.row].image
        let encodedString = imageStringURL.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        imageView.imageFromUrl(encodedString, placeholder: nil, success: { (image) in
            if cell.marker == marker {
                cell.postImageView.image = image
            }
            }, failure: nil)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedPost = self.posts[indexPath.row]
        self.delegate?.postSelected(selectedPost)
        
        self.delegate?.reloadCellChash({ 
            self.tableView.reloadData()
        })
        
        if let detailViewController = self.delegate as? PostController {
            if IS_IPHONE {
                splitViewController?.showDetailViewController(detailViewController.navigationController!, sender: nil)
            }
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return (indexPath.row%5) == 0 ? 230 : 90
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if (indexPath.item >= posts.count-5) {
            loadingNextPosts()
        }
    }
    
    //MARK: - Private methods
    
    private func loadingPosts(offset: Int, refresh: Bool = false, complete: (() -> Void)?)
    {
        if (loadingOffsetMarker != nil && loadingOffsetMarker == offset) {
            return
        }
        
        loadingOffsetMarker = offset
        
        let page = lroundf(Float(offset) / Float(productPerPage)) + 1
        
        Post.getAllPosts(page, refresh: refresh) {
            
            self.posts = try! Realm().objects(Post).sorted("date", ascending: false).list
            
            self.loadingOffsetMarker = nil
            
            self.tableView.reloadData()
            
            if complete != nil {
                complete!()
            }
        }
    }
    
    private func loadingNextPosts()
    {
        loadingPosts(posts.count, complete: nil)
    }
    
    @objc private func refresh(sender:AnyObject)
    {
        loadingPosts(0, refresh: true) {
            self.delegate?.postSelected(self.posts[0])
            self.refreshControl?.endRefreshing()
        }
    }

}
