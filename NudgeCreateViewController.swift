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
    
    
    @IBOutlet weak var frequencyControl: UISegmentedControl!
    
    var nudgeInterval = NSTimeInterval()
    
    @IBAction func didTapNudgeButton(sender: AnyObject) {
        let selectedFrequencyIndex = frequencyControl.selectedSegmentIndex
        
        switch selectedFrequencyIndex {
        case 0:
            nudgeInterval = NSTimeInterval(3600)
        case 1:
            nudgeInterval = NSTimeInterval(14400)
        case 2:
            nudgeInterval = NSTimeInterval(86400)
        default:
            break
        }
        
        let nudgeObject = PFObject(className: "Nudge")
        var senderID: PFUser!
        if let currentUser = PFUser.currentUser() {
            senderID = currentUser
        } else {
            // senderID = PF // TODO: fix this nonsense.
        }
        nudgeObject.setObject(senderID, forKey: "senderID")
        nudgeObject.setObject(messageTextField.text, forKey: "message")
        nudgeObject.setObject(recipientTextField.text, forKey: "recipient")
        nudgeObject.setObject(0, forKey: "status")
        nudgeObject.setObject(nudgeInterval, forKey: "reminderFrequencyInSeconds")
        
        let ACL = PFACL()
        ACL.setPublicReadAccess(true)
        ACL.setPublicWriteAccess(true)
        nudgeObject.ACL = ACL
        nudgeObject.saveInBackgroundWithBlock {
            (success,error) -> Void in
            if success == true {
                self.recipientTextField.text = ""
                self.messageTextField.text = ""
                self.navigationController?.popToRootViewControllerAnimated(true)
            }
            else {
                println("error \(error)")
            }
        }
        
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

enum Frequency {
    case Hourly
    case FourHourly
    case Daily
}