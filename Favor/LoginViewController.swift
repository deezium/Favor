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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let digitsButton = DGTAuthenticateButton(authenticationCompletion: {
            (session, error) in
            if session != nil {
                println(session.phoneNumber)
                println(session.userID)
                let userObject = PFObject(className: "User")
                userObject.setObject(session.phoneNumber, forKey: "phoneNumber")
                userObject.setObject(session.userID, forKey: "digitsID")
                let ACL = PFACL()
                ACL.setPublicReadAccess(true)
                ACL.setPublicWriteAccess(true)
                userObject.ACL = ACL
                userObject.saveInBackgroundWithBlock {
                    (success, error) -> Void in
                    if success == true {
                        println("user successfully saved")
                    }
                }
                self.performSegueWithIdentifier("showMainApp", sender: self)
            
            }
        })
        
        digitsButton.center = view.center
        digitsButton.addTarget(self, action: "didTapDigitsButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(digitsButton)
        
        
        
        
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