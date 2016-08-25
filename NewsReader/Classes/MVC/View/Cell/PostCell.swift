//
//  PostCell.swift
//  NewsReader
//
//  Created by StPashik on 24.08.16.
//  Copyright © 2016 StDevelop. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    internal var marker: NSObject?
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var postCashImage: UIImageView!
    
    @IBOutlet weak var titleHeight: NSLayoutConstraint!
    @IBOutlet weak var dateWidth: NSLayoutConstraint!

    internal var post: Post! {
        didSet {
            
            postTitleLabel.text = post.title
            postDateLabel.text = post.date.afterDate(NSDate(), dateFormat: "dd.MM.yy")
            
            postCashImage.hidden = post.content != ""
            
            titleHeight.constant = postTitleLabel.optimalHeight(51)
            dateWidth.constant = postDateLabel.optimalWidth()
            setNeedsUpdateConstraints()
            
        }
    }
    
    override func prepareForReuse() {
        
        postImageView.image = nil
        postTitleLabel.text = ""
        postDateLabel.text = ""
        
    }

}
