//
//  CredentialOverviewTableViewController.swift
//  Passing Your Password
//
//  Created by Andrew Arnopoulos on 4/10/15.
//  Copyright (c) 2015 Spaghettio. All rights reserved.
//

import UIKit

class CredentialOverviewTableViewController: UITableViewController {
	
	var userData = UserData.defaultUserData

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
		userData.add(credential: Credential(url: "netflix.com", userName: "Andrew", password: "1234"))
		userData.add(credential: Credential(url: "facebook.com", userName: "Swisher", password: "password"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return userData.credentials.count
    }
	
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CredentialOverviewCell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
		cell.textLabel?.text = userData.credentials[indexPath.row].url

        return cell
    }
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if let sender = sender as? UITableViewCell {
			let indexPath = tableView.indexPathForCell(sender)!
			let credential = userData.credentials[indexPath.row]
			let destinationViewController = segue.destinationViewController as! CredentialViewController
			destinationViewController.credential = credential
		}
	}

}
