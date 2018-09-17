//
//  AppDelegate.swift
//  CustomControls
//
//  Created by Jordan Morgan on 2/28/16.
//  Copyright © 2016 Dreaming In Binary. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        let keys:AnyObject = NSArray(objects: NSAttributedStringKey.foregroundColor, NSAttributedStringKey.font)
        let navBarFontVals:AnyObject = NSArray(objects: UIColor.black, UIFont(name: "Avenir", size: 24)!)
        let navBartextAttributes:NSDictionary = NSDictionary(objects: navBarFontVals as! [AnyObject], forKeys: keys as! [NSCopying])
        UINavigationBar.appearance().titleTextAttributes = navBartextAttributes as? [NSAttributedStringKey : Any]
        return true
    }

}

