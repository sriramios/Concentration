//
//  AppDelegate.swift
//  Concentration
//
//  Created by sriram on 01/06/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setRootViewController()
        return true
    }
    
    func setRootViewController() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let homeVc = CardsViewRouter.createModule()
        let navigationController = UINavigationController()
        navigationController.viewControllers = [homeVc]
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
}

