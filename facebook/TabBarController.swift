//
//  TabBarController.swift
//  facebook
//
//  Created by Tsang Ka Kui on 10/8/2016.
//  Copyright © 2016年 Tsang Ka Kui. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let feedController = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        let firstTabController = UINavigationController(rootViewController: feedController)
        firstTabController.title = "News Feed"
        firstTabController.tabBarItem.image = UIImage(named: "news_feed_icon")
        
        let friendController = UIViewController()
        friendController.view.backgroundColor = UIColor.whiteColor()
        friendController.navigationItem.title = "Requests"
        let secondTabController = UINavigationController(rootViewController: friendController)
        secondTabController.title = "Requests"
        secondTabController.tabBarItem.image = UIImage(named: "requests_icon")
        
        let messengerController = UIViewController()
        messengerController.view.backgroundColor = UIColor.whiteColor()
        messengerController.navigationItem.title = "Messenger"
        let thirdTabController = UINavigationController(rootViewController: messengerController)
        thirdTabController.title = "Messenger"
        thirdTabController.tabBarItem.image = UIImage(named: "messenger_icon")
        
        let notificationController = UIViewController()
        notificationController.view.backgroundColor = UIColor.whiteColor()
        notificationController.navigationItem.title = "Notification"
        let fourthTabController = UINavigationController(rootViewController: notificationController)
        fourthTabController.title = "Messenger"
        fourthTabController.tabBarItem.image = UIImage(named: "globe_icon")
        
        let moreController = UIViewController()
        moreController.view.backgroundColor = UIColor.whiteColor()
        moreController.navigationItem.title = "Notification"
        let fifthTabController = UINavigationController(rootViewController: moreController)
        fifthTabController.title = "Messenger"
        fifthTabController.tabBarItem.image = UIImage(named: "more_icon")
        
        viewControllers = [firstTabController, secondTabController, thirdTabController, fourthTabController, fifthTabController]
        
        let topBorder = CALayer()
        topBorder.frame = CGRectMake(0, 0, 1000, 0.5)
        topBorder.backgroundColor = UIColor.rgb(229, 231, 235).CGColor
        
        tabBar.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true
    }

}
