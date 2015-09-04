//
//  NudgeQueryController.swift
//  Favor
//
//  Created by Andrew Brown on 9/3/15.
//  Copyright (c) 2015 Wavelength. All rights reserved.
//

import Foundation
import Parse

@objc protocol QueryControllerProtocol {
    func didReceiveQueryResults(objects: [PFObject])
}

class QueryController {
    
    var delegate: QueryControllerProtocol?
    
    func getNudgesForUser(userName name: String) {
        var query = PFQuery(className: "Nudge")
        let currentUser = name
        var objects = query.findObjects() as? [PFObject]
        self.delegate?.didReceiveQueryResults(objects!)
    }
}