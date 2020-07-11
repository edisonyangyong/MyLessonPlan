//
//  AppDelegate.swift
//  MyLessonPlan
//
//  Created by Yong Yang on 4/9/20.
//  Copyright © 2020 Edison Yang. All rights reserved.
//

import UIKit
#if !targetEnvironment(macCatalyst)
    import IQKeyboardManagerSwift
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
     
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        #if !targetEnvironment(macCatalyst)
            IQKeyboardManager.shared.enable = true
        #endif
        
        // disable all animations during the ui testing process
        if (ProcessInfo.processInfo.environment["UITEST_DISABLE_ANIMATIONS"] == "YES") {
            print(">>>>>>>>>>>>>>>>>>> Start UI Testing")
            UIView.setAnimationsEnabled(false)
        }else{
            print(">>>>>>>>>>>>>>>>>>> Normal Model")
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

