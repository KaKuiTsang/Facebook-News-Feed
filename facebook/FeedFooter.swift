//
//  FeedFooter.swift
//  facebook
//
//  Created by Tsang Ka Kui on 8/8/2016.
//  Copyright © 2016年 Tsang Ka Kui. All rights reserved.
//

import UIKit

class FeedFooter: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var likesCommentCountLabel: UILabel = {
        let label = UILabel()
        label.text = "100 Likes   34 Comments"
        label.font = UIFont.systemFontOfSize(11)
        label.textColor = UIColor.rgb(155, 161, 171)
        return label
    }()
    
    var dividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(226, 228, 232)
        return view
    }()
    
    var buttonStack: UIStackView = {
        
        var likeButton = FeedFooter.createButton("Like", image: "like")
        var commentButton = FeedFooter.createButton("Comment", image: "comment")
        var shareButton = FeedFooter.createButton("Share", image: "share")
        
        let subViews = [likeButton, commentButton, shareButton]
        let stack = UIStackView(arrangedSubviews: subViews)
        stack.axis = .Horizontal
        stack.distribution = .FillEqually
        return stack
    }()
    
    func setupViews() {
        heightAnchor.constraintEqualToConstant(80).active = true
    
        addSubviews(likesCommentCountLabel)
        likesCommentCountLabel.topAnchor.constraintEqualToAnchor(topAnchor).active = true
        likesCommentCountLabel.leadingAnchor.constraintEqualToAnchor(leadingAnchor, constant: 10).active = true
        likesCommentCountLabel.trailingAnchor.constraintEqualToAnchor(trailingAnchor,constant: -10).active = true
        likesCommentCountLabel.heightAnchor.constraintEqualToConstant(35).active = true
        
        addSubviews(dividerLine)
        dividerLine.topAnchor.constraintEqualToAnchor(likesCommentCountLabel.bottomAnchor).active = true
        dividerLine.leadingAnchor.constraintEqualToAnchor(leadingAnchor, constant: 10).active = true
        dividerLine.trailingAnchor.constraintEqualToAnchor(trailingAnchor, constant: -10).active = true
        dividerLine.heightAnchor.constraintEqualToConstant(0.5).active = true
        
        addSubviews(buttonStack)
        buttonStack.topAnchor.constraintEqualToAnchor(dividerLine.bottomAnchor).active = true
        buttonStack.bottomAnchor.constraintEqualToAnchor(bottomAnchor).active = true
        buttonStack.leadingAnchor.constraintEqualToAnchor(leadingAnchor).active = true
        buttonStack.trailingAnchor.constraintEqualToAnchor(trailingAnchor).active = true
    }
    
    static func createButton(title: String, image: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, forState: .Normal)
        button.setTitleColor(UIColor.rgb(143, 150, 163), forState: .Normal)
        button.setImage(UIImage(named: image), forState: .Normal)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0)
        button.titleLabel?.font = UIFont.systemFontOfSize(13)
        button.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        button.imageEdgeInsets = UIEdgeInsetsMake(12, 12, 12, 12);
        return button
    }
}