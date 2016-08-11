//
//  FeedCell.swift
//  facebook
//
//  Created by Tsang Ka Kui on 7/8/2016.
//  Copyright © 2016年 Tsang Ka Kui. All rights reserved.
//

import UIKit
import AVFoundation

let imageCache = NSCache()

class FeedCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var controller: FeedController?
    
    var post: Post? {
        didSet {
            loader.startAnimating()
            setProfileImageAndHeaderText()
            fetchStatusImage()
        }
    }
    
    var header: FeedHeader = {
        let header = FeedHeader()
        return header
    }()
    
    var statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(13)
        label.lineBreakMode = .ByWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    var statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    var footer: FeedFooter = {
        let footer = FeedFooter()
        return footer
    }()
    
    let loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
        loader.hidesWhenStopped = true
        loader.color = UIColor.blackColor()
        return loader
    }()
    
    func setProfileImageAndHeaderText() {
        let attributes = [NSFontAttributeName: UIFont.boldSystemFontOfSize(14)]
        let attributedText = NSMutableAttributedString(string: (post?.name)!, attributes: attributes)
        
        let secondLineAttributes = [
            NSFontAttributeName: UIFont.systemFontOfSize(12),
            NSForegroundColorAttributeName: UIColor.rgb(155, 161,161)
        ]
        let secondLineAttributedText = NSAttributedString(string: "\nAugust 10 • Hong Kong • ", attributes: secondLineAttributes)
        attributedText.appendAttributedString(secondLineAttributedText)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.characters.count))
        
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "globe_small")
        attachment.bounds = CGRectMake(0, -2, 12, 12)
        attributedText.appendAttributedString(NSAttributedString(attachment: attachment))
        
        header.infoLabel.attributedText = attributedText
        header.profileImageView.image = UIImage(named: (post?.profileImageName!)!)
    }
    
    func fetchStatusImage() {
        
        if let image = imageCache.objectForKey((post?.statusImageUrl)!) as? UIImage {
            statusImageView.image = image
            loader.stopAnimating()
            return
        }
        
        statusImageView.image = nil
        
        let url = NSURL(string: (post?.statusImageUrl!)!)
        
        NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            if let image = UIImage(data: data!) {
                
                imageCache.setObject(image, forKey: (self.post?.statusImageUrl!)!)
                
                self.post?.statusImageRect = AVMakeRectWithAspectRatioInsideRect(image.size, CGRectMake(0,0, self.frame.width, CGFloat.max))
                
                self.post?.statusImageLoaded = true
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.statusImageView.image = image
                    self.loader.stopAnimating()
                    NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "imageLoaded", object: nil))
                })
            }
            
        }.resume()
        
    }
    
    func setupViews() {
        addSubviews(header)
        addSubviews(statusLabel)
        addSubviews(statusImageView)
        addSubviews(footer)
        addSubviews(loader)
        
        // header
        header.topAnchor.constraintEqualToAnchor(topAnchor).active = true
        header.leadingAnchor.constraintEqualToAnchor(leadingAnchor).active = true
        header.trailingAnchor.constraintEqualToAnchor(trailingAnchor).active = true
        
        // text
        statusLabel.topAnchor.constraintEqualToAnchor(header.bottomAnchor).active = true
        statusLabel.leadingAnchor.constraintEqualToAnchor(leadingAnchor, constant: 8).active = true
        statusLabel.trailingAnchor.constraintEqualToAnchor(trailingAnchor, constant: -8).active = true
        statusLabel.setContentHuggingPriority(750 , forAxis: .Vertical)
        statusLabel.setContentCompressionResistancePriority(250, forAxis: .Vertical)
        
        //image
        statusImageView.topAnchor.constraintEqualToAnchor(statusLabel.bottomAnchor, constant: 8).active = true
        statusImageView.leadingAnchor.constraintEqualToAnchor(leadingAnchor).active = true
        statusImageView.trailingAnchor.constraintEqualToAnchor(trailingAnchor).active = true
        statusImageView.bottomAnchor.constraintEqualToAnchor(footer.topAnchor).active = true
        statusImageView.userInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTappedStatusImageView))
        statusImageView.addGestureRecognizer(tapGesture)
        
         //footer
        footer.topAnchor.constraintEqualToAnchor(statusImageView.bottomAnchor).active = true
        footer.bottomAnchor.constraintEqualToAnchor(bottomAnchor).active = true
        footer.leadingAnchor.constraintEqualToAnchor(leadingAnchor).active = true
        footer.trailingAnchor.constraintEqualToAnchor(trailingAnchor).active = true
        
        //loader
        loader.widthAnchor.constraintEqualToConstant(100).active = true
        loader.heightAnchor.constraintEqualToConstant(100).active = true
        loader.centerXAnchor.constraintEqualToAnchor(statusImageView.centerXAnchor).active = true
        loader.centerYAnchor.constraintEqualToAnchor(statusImageView.centerYAnchor).active = true
    }
    
    func didTappedStatusImageView() {
        if post?.statusImageLoaded == true {
            controller?.imageZoomIn(statusImageView)
        }
    }
    
}
