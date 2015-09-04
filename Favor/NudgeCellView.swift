//
//  NudgeCellView.swift
//  Favor
//
//  Created by Andrew Brown on 9/3/15.
//  Copyright (c) 2015 Wavelength. All rights reserved.
//

import UIKit
import Parse

class NudgeCellView: UITableViewCell {
    // TODO
    
    @IBOutlet weak var messageTextLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var leftNameLabel: UILabel!
    
    func setWithNudge(nudge: PFObject) {
        messageTextLabel.text = nudge.objectForKey("message") as! String
        leftNameLabel.text = nudge.objectForKey("sender") as! String
    }
}
