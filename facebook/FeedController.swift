//
//  ViewController.swift
//  facebook
//
//  Created by Tsang Ka Kui on 7/8/2016.
//  Copyright © 2016年 Tsang Ka Kui. All rights reserved.
//

import UIKit
//import AVFoundation

let posts = Posts()

class FeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var startingFrame: CGRect?
    
    var targetImageView = UIImageView()
    
    var zoomImageView = UIImageView()
    
    var blackBackgroundCover = UIView()
    
    var navBarCover = UIView()
    
    var tabBarCover = UIView()
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Facebook"
        collectionView?.backgroundColor = UIColor.rgb(205, 205, 205)
        collectionView?.alwaysBounceVertical = true
        collectionView?.registerClass(FeedCell.self, forCellWithReuseIdentifier: "FeedCell")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(invaldateLayout), name: "imageLoaded", object: nil)
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.numberOfPosts()
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let post = posts[indexPath]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FeedCell", forIndexPath: indexPath) as! FeedCell
        cell.controller = self
        cell.post = post
        cell.statusLabel.text = post.statusText
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var cellHeight:CGFloat = 0
        let post = posts[indexPath]
        let textRect = NSString(string: post.statusText!).boundingRectWithSize(CGSizeMake(view.frame.width, 1000), options: NSStringDrawingOptions.UsesFontLeading.union(NSStringDrawingOptions.UsesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.systemFontOfSize(14)], context: nil)
        
        if post.statusImageLoaded == true {
            cellHeight = 56 + textRect.height + 8 + post.statusImageRect!.height + 80
        } else {
            cellHeight = 56 + textRect.height + 200 + 80
        }
        
        return CGSizeMake(view.bounds.width, cellHeight)
    }
    
    func invaldateLayout() {
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    func imageZoomIn(targetImageView: UIImageView) {
        
        if let startingFrame = targetImageView.superview?.convertRect(targetImageView.frame, toView: nil) {
            
            self.targetImageView = targetImageView
            
            self.startingFrame = startingFrame
            
            targetImageView.alpha = 0
            
            // black backgorund cover
            blackBackgroundCover.backgroundColor = UIColor.blackColor()
            blackBackgroundCover.alpha = 0
            blackBackgroundCover.frame = view.frame
            view.addSubview(blackBackgroundCover)
            
            if let keyWindow = UIApplication.sharedApplication().keyWindow {
        
                // nav bar cover
                navBarCover.backgroundColor = UIColor.blackColor()
                navBarCover.alpha = 0
                navBarCover.frame = (navigationController?.navigationBar.frame)!
                keyWindow.addSubview(navBarCover)
                
                // tab bar cover
                tabBarCover.backgroundColor = UIColor.blackColor()
                tabBarCover.alpha = 0
                tabBarCover.frame = CGRectMake(0, keyWindow.frame.height - 49, 1000, 49)
                keyWindow.addSubview(tabBarCover)
            }
            
            // zoom image
            zoomImageView.frame = startingFrame
            zoomImageView.image = targetImageView.image
            zoomImageView.contentMode = .ScaleAspectFill
            zoomImageView.userInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageZoomOut))
            zoomImageView.addGestureRecognizer(tapGesture)
            view.addSubview(zoomImageView)
            
            UIView.animateWithDuration(0.5, animations: {
                
                self.blackBackgroundCover.alpha = 1
                self.navBarCover.alpha = 1
                self.tabBarCover.alpha = 1
                
                let y = (self.view.frame.height / 2) - (self.zoomImageView.frame.height / 2)
                self.zoomImageView.frame = CGRectMake(0, y, self.zoomImageView.frame.width, self.zoomImageView.frame.height)
                
            })

        }
        
    }
    
    func imageZoomOut() {
        
        UIView.animateWithDuration(0.5, animations: {
            self.zoomImageView.frame = self.startingFrame!
            self.blackBackgroundCover.alpha = 0
            self.navBarCover.alpha = 0
            self.tabBarCover.alpha = 0
            
        }) { (didComplete) in
            self.zoomImageView.removeFromSuperview()
            self.blackBackgroundCover.removeFromSuperview()
            self.navBarCover.removeFromSuperview()
            self.tabBarCover.removeFromSuperview()
            self.targetImageView.alpha = 1
        }
        
    }
}

