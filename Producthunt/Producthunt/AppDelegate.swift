//
//  AppDelegate.swift
//  Producthunt
//
//  Created by Господин Бог on 17.07.17.
//  Copyright © 2017 Господин Бог. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        DNServer.shared.loadPost(with: 103728, callBack: {_ in })
        return true
    }
}
