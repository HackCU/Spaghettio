//
//  CredentialTableViewController.swift
//  Passing Your Password
//
//  Created by Andrew Arnopoulos on 4/12/15.
//  Copyright (c) 2015 Spaghettio. All rights reserved.
//

import UIKit

class CredentialTableViewController: UITableViewController {
	var credential:Credential! {
		didSet {
			navigationItem.title = credential.url
			tableView.reloadData()
		}
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 2
	}
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 2
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("CCell") as! UITableViewCell
		if indexPath.section == 0 {
			if indexPath.row == 0 {
				cell.textLabel?.text = credential.userName
			} else if indexPath.row == 1 {
				cell.textLabel!.text = credential.password
			}
		} else if indexPath.section == 1 {
			if indexPath.row == 0 {
				cell.textLabel?.textColor = UIColor.blackColor()
				cell.textLabel?.textAlignment = .Center
				cell.textLabel!.text = "Share"
			} else if indexPath.row == 1 {
				cell.textLabel?.textColor = UIColor.redColor()
				cell.textLabel?.textAlignment = .Center
				cell.textLabel!.text = "Delete"
			}
		}
		
		return cell
	}
	
	override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if section == 0 {
			return "Username and Password"
		} else {
			return ""
		}
	}
}
