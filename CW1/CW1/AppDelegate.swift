//
//  AppDelegate.swift
//  CW1
//
//  Created by Lind Zariqi on 16/03/2022.
//

import UIKit
import AudioToolbox

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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

// filter the TF input for calculation
extension UITextField {
    var filteredText: String {
        get {
            let text = self.text!.filter("1234567890.".contains)
            return text
        }
    }
    
    var validateDouble: Double! {
        get {
            let text = self.text!.filter("1234567890.".contains)
            return Double(text)
        }
    }
}
