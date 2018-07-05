//
//  AppDelegate.swift
//  contentful-ios-dialogs
//
//  Created by JP Wright on 05.07.18.
//  Copyright © 2018 Boris Bügling. All rights reserved.
//

import UIKit
import ContentfulDialogs

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let vc = AboutUsViewController()
        
        window?.backgroundColor = .white
        return true
    }
}
