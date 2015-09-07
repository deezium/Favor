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

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let digitsButton = DGTAuthenticateButton(authenticationCompletion: {
            (session, error) in
            if session != nil {
                println(session.phoneNumber)
                println(session.userID)
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