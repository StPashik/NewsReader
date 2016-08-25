//
//  AppDelegate.swift
//  NewsReader
//
//  Created by StPashik on 24.08.16.
//  Copyright © 2016 StDevelop. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let splitViewController = self.window!.rootViewController as! UISplitViewController
        splitViewController.preferredDisplayMode = .AllVisible
        
        let leftNavController = splitViewController.viewControllers.first as! UINavigationController
        let masterViewController = leftNavController.topViewController as! MenuController
        
        let rightNavController = splitViewController.viewControllers.last as! UINavigationController
        let detailViewController = rightNavController.topViewController as! PostController
        
        masterViewController.delegate = detailViewController
        
        setupAppirance()
        
        return true
    }
    
    func application(application: UIApplication, supportedInterfaceOrientationsForWindow window: UIWindow?) -> UIInterfaceOrientationMask
    {
        return UIInterfaceOrientationMask.All
    }
    
    private func setupAppirance()
    {   
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
    }


}

