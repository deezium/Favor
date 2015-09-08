//
//  LoginViewController.swift
//  Favor
//
//  Created by Andrew Brown on 9/7/15.
//  Copyright (c) 2015 Wavelength. All rights reserved.
//

import Foundation
import UIKit
import DigitsKit
import Parse

class LoginViewController: UIViewController {
    
    let defaultPassword = "defaultPassword"
    let showMainAppIdentifier = "showMainApp"

    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if let user = PFUser.currentUser() {
            println("current user is \(user)")
            performSegueWithIdentifier(showMainAppIdentifier, sender: self)
        } else {
            
            let digitsButton = DGTAuthenticateButton(authenticationCompletion: {
                (session, error) in
                if session != nil {
                    
                    let user = PFUser()
                    user.username = session.phoneNumber
                    user.password = self.defaultPassword
                    user.signUpInBackgroundWithBlock({
                        (success, error) in
                        if error != nil {
                            println("error is \(error)")
                        } else {
                            println("success is \(success)")
                        }
                    })
                    
                    user.saveInBackgroundWithBlock({
                        (success, error) in
                        if error != nil {
                            println("error is \(error)")
                        } else {
                            println("success is \(success)")
                        }
                    })
                    
                    
                    //                PFUser.logInWithUsernameInBackground(session!.phoneNumber!, password: self.defaultPassword) {
                    //                    (user: PFUser!, error: NSError!) -> Void in
                    //                    if user != nil {
                    //                        // Yes, User Exists
                    //                        self.loginInitialLabel.text = "User Exists"
                    //                    } else {
                    //                        // No, User Doesn't Exist
                    //                    }
                    //                }
                    
                    //                let nudgeUser = NudgeUser(className: "NudgeUser", dictionary: <#[NSObject : AnyObject]?#>)
                    
                    //                let userObject = PFObject(className: "User")
                    //                userObject.setObject(session.phoneNumber, forKey: "phoneNumber")
                    //                userObject.setObject(session.userID, forKey: "digitsID")
                    //                let ACL = PFACL()
                    //                ACL.setPublicReadAccess(true)
                    //                ACL.setPublicWriteAccess(true)
                    //                userObject.ACL = ACL
                    //                userObject.saveInBackgroundWithBlock {
                    //                    (success, error) -> Void in
                    //                    if success == true {
                    //                        println("user successfully saved")
                    //                    }
                    //                }
                    self.performSegueWithIdentifier("showMainApp", sender: self)
                    
                }
            })
            
            digitsButton.center = view.center
            digitsButton.addTarget(self, action: "didTapDigitsButton:", forControlEvents: .TouchUpInside)
            self.view.addSubview(digitsButton)
        }
    }
    
    func didTapDigitsButton(sender: AnyObject) {
        let digits = Digits.sharedInstance()
        
//        digits.authenticateWithCompletion {
//            (session, error) in
//            if session != nil {
//                println(session.phoneNumber)
//                println(session.userID)
//            }
//        }
    }
    
}



