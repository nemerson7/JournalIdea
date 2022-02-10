//
//  AppDelegate.swift
//  JournalIdea
//
//  Created by Nick Emerson on 6/7/21.
//
//  Team: Team07
//  Members: Aagam Shah (as19@iu.edu) and Nick Emerson (nemerso@iu.edu)
//  Project Name: JournalIdea
//  Submission Date: June 17, 2021


import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var myModel = JournalIdeaModel()
    var udpSender: UDPSender?
    let myNotificationCenter = UNUserNotificationCenter.current()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Loading persistent model
        do {
            let fm = FileManager.default
            let docsurl = try fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let inFile = docsurl.appendingPathComponent("appData.plist")
            let fileData = try Data(contentsOf: inFile)
            let tempModel = try PropertyListDecoder().decode(JournalIdeaModel.self, from: fileData)
            self.myModel = tempModel
            print("appData.plist successfully read.")
        } catch {
            print(error)
        }
        
        
        let allowedOptions: UNAuthorizationOptions = [.alert]
        self.myNotificationCenter.requestAuthorization(options: allowedOptions) { (status, error) in
            status ? print("Notifications allowed") : print("Notifications not allowed")
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

