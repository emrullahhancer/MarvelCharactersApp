//
//  AppDelegate.swift
//  MarvelCharactersApp
//
//  Created by Emrullah Hancer on 12.08.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if let window = window {
            let storyboard = UIStoryboard(name: "Tabbar", bundle: Bundle.main)
            let view = storyboard.instantiateViewController(withIdentifier: "ApplicationTabbarController") as! ApplicationTabbarController
            window.rootViewController = view
            window.makeKeyAndVisible()
        }
        
        return true
    }
    
    func showMain() {
        
        
    }


    

}

