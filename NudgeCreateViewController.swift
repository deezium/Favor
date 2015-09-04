//
//  NudgeCreateViewController.swift
//  Favor
//
//  Created by Andrew Brown on 9/3/15.
//  Copyright (c) 2015 Wavelength. All rights reserved.
//

import UIKit
import Parse

class NudgeCreateViewController: UIViewController {
    
    @IBOutlet weak var recipientTextField: UITextField!
    
    @IBOutlet weak var messageTextField: UITextField!
    
    @IBAction func didTapNudgeButton(sender: AnyObject) {
        let nudgeObject = PFObject(className: "Nudge")
        nudgeObject.setObject("Andy", forKey: "sender")
        nudgeObject.setObject(messageTextField.text, forKey: "message")
        nudgeObject.setObject(recipientTextField.text, forKey: "recipient")
        nudgeObject.setObject(0, forKey: "status")
        
        let ACL = PFACL()
        ACL.setPublicReadAccess(true)
        ACL.setPublicWriteAccess(true)
        nudgeObject.ACL = ACL
        nudgeObject.saveInBackground()
        
        let parent = navigationController!.viewControllers[0] as! NudgeListViewController
        
        parent.query.getNudgesForUser(userName: "Andy")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
