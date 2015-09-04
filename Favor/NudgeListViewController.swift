//
//  NudgeListViewController.swift
//  Favor
//
//  Created by Andrew Brown on 9/3/15.
//  Copyright (c) 2015 Wavelength. All rights reserved.
//

import UIKit
import Parse

class NudgeListViewController: UIViewController {
    
    let cellIdentifier = "nudgeCell"
    let createNudgeSegueIdentifier = "showCreateNudgeSegue"
    var nudges: [PFObject]!
    var query = QueryController()
    
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        query.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        query.getNudgesForUser(userName: "Andy")
        println("nudges \(nudges)")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension NudgeListViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numNudges = nudges?.count {
            return numNudges
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! NudgeCellView
        let nudge = nudges[indexPath.row]
        cell.setWithNudge(nudge)
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
}

extension NudgeListViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // TODO
    }
}

extension NudgeListViewController: QueryControllerProtocol {
    func didReceiveQueryResults(objects: [PFObject]) {
        dispatch_async(dispatch_get_main_queue(), {
            self.nudges = objects
            self.tableView.reloadData()
        })
    }
}
