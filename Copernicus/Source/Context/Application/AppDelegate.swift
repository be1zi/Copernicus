//
//  AppDelegate.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 14/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import UIKit

private enum ApplicationProperties: String {
    case skipWalkthrough
    case skipToHome
    
    public func value() -> String {
        return self.rawValue
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    static var sharedInstance: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var window: UIWindow?

    lazy var windowController: WindowController? = {
        
        guard let window = window else {
            return nil
        }
        
        let wc = WindowController.init(window: window)

        return wc
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        configureUserInterface()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }
    
    //
    // MARK: - Configurations
    //
    
    func configureUserInterface() {
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        shouldSkipToHome == true ? windowController?.presentHomeController() : windowController?.presentLanguageController()
        window?.makeKeyAndVisible()
    }
    
    //
    // MARK: - Stored properties
    //
    
    public var shouldSkipWalkthrough: Bool  {
        set {
            UserDefaults.standard.set(newValue, forKey: ApplicationProperties.skipWalkthrough.value())
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.object(forKey: ApplicationProperties.skipWalkthrough.value()) as? Bool ?? false
        }
    }
    
    public var shouldSkipToHome: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: ApplicationProperties.skipToHome.value())
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.object(forKey: ApplicationProperties.skipToHome.value()) as? Bool ?? false
        }
    }
}

