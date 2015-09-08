//
//  AppDelegate.swift
//  Favor
//
//  Created by Debarshi Chaudhuri on 9/3/15.
//  Copyright (c) 2015 Wavelength. All rights reserved.
//

import UIKit
import Parse
import Bolts
import Fabric
import Crashlytics
import DigitsKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var users: [PFObject]?
    var query = QueryController()
    
    var loggedInViewControllerIdentifier = "rootNavigationController"
    var notLoggedInViewControllerIdentifier = "loginViewController"
    
    var initialViewControllerIdentifier: String!
    
//    var user: PFUser?
    
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        query.delegate = self
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let digitsSession = Digits.sharedInstance().session() {
//            println("digits session is \(digitsSession)")
//            query.getUserForPhoneNumber(digitsSession.phoneNumber)
//            if let user = users?.first! as? PFUser {
//                println("user is \(user)")
//            }
            
            
            
            // TODO: make the current user correspond to this session (link Digits --> PFUser)
            initialViewControllerIdentifier = loggedInViewControllerIdentifier
        } else {
            initialViewControllerIdentifier = notLoggedInViewControllerIdentifier
        }
        
        let viewController: UIViewController = storyboard.instantiateViewControllerWithIdentifier(initialViewControllerIdentifier) as! UIViewController
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
        
        // [Optional] Power your app with Local Datastore. For more info, go to
        // https://parse.com/docs/ios_guide#localdatastore/iOS
        Parse.enableLocalDatastore()
        
        // Initialize Parse.
        Parse.setApplicationId("JnchmxQSmsitoM0hsgvJAIN1mH5DgQP65NeTL3tO",
            clientKey: "CigZvAVjTrHFHTuHEOes56iJEdggh0d6nRa2bCCx")
        

        
        Fabric.with([Crashlytics.self(), Digits.self()])
        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

extension AppDelegate: QueryControllerProtocol {
    func didReceiveQueryResults(objects: [PFObject]) {
        dispatch_async(dispatch_get_main_queue(), {
            self.users = objects as? [PFObject]
            if self.users!.count > 1 {
                println("SOMETHING HAS GONE TERRIBLY WRONG! More than 1 user?!")
            }
        })
    }
}

