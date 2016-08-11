//
//  FeedHeader.swift
//  facebook
//
//  Created by Tsang Ka Kui on 8/8/2016.
//  Copyright © 2016年 Tsang Ka Kui. All rights reserved.
//

import UIKit

class FeedHeader: UIView {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var profileImageView: UIImageView =  {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFit
        return imageView
    }()
    
    var infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    func setupViews() {
        addSubviews(profileImageView)
        addSubviews(infoLabel)
        
        heightAnchor.constraintEqualToConstant(56).active = true
        
        profileImageView.widthAnchor.constraintEqualToConstant(40).active = true
        profileImageView.heightAnchor.constraintEqualToConstant(40).active = true
        profileImageView.centerYAnchor.constraintEqualToAnchor(centerYAnchor).active = true
        profileImageView.leadingAnchor.constraintEqualToAnchor(leadingAnchor, constant: 8).active = true
        
        infoLabel.centerYAnchor.constraintEqualToAnchor(centerYAnchor).active = true
        infoLabel.heightAnchor.constraintEqualToConstant(40).active = true
        infoLabel.leadingAnchor.constraintEqualToAnchor(profileImageView.trailingAnchor, constant: 8).active = true
        infoLabel.trailingAnchor.constraintEqualToAnchor(trailingAnchor, constant: -8).active = true
        
    }
    
}