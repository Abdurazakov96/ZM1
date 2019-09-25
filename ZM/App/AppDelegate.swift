//
//  AppDelegate.swift
//  ZM
//
//  Created by Магомед Абдуразаков on 14/09/2019.
//  Copyright © 2019 Магомед Абдуразаков. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    //Mark: Public properties
    
    var window: UIWindow?
    static var orderTabBarItem: UITabBarItem!
    
    
    //Mark: Public methods
    
    @objc func changeTabBarItem() {
        let count = OrderManager.shared.order.MenuItems.count
        if count != 0 { AppDelegate.orderTabBarItem.badgeValue = "\(count)" }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let temporaryDirectory = NSTemporaryDirectory()
        let urlCache = URLCache(memoryCapacity: 25_000_000, diskCapacity: 50_000_000, diskPath: temporaryDirectory)
        URLCache.shared = urlCache
        let tabBarController = window?.rootViewController as? UITabBarController
        AppDelegate.orderTabBarItem = tabBarController?.viewControllers![1].tabBarItem
        NotificationCenter.default.addObserver(self, selector: #selector (changeTabBarItem), name: OrderManager.orderUpdatedNotification, object: nil)
        return true
    }
    
}

