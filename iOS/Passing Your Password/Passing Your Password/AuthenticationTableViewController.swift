//
//  AuthenticationTableViewController.swift
//  Passing Your Password
//
//  Created by Andrew Arnopoulos on 4/11/15.
//  Copyright (c) 2015 Spaghettio. All rights reserved.
//

import UIKit
import LocalAuthentication

class AuthenticationTableViewController: UITableViewController {
	
	var authenticationTypes:[String]?
	var hasTouchID:Bool = false
	let localAuthenticationContext = LAContext()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
		var error:NSError? = nil
		hasTouchID = localAuthenticationContext.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error)
		authenticationTypes = (hasTouchID) ? ["Touch ID","Facial Recognition","Password"] : ["Facial Recognition","Password"]
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
		if let count = authenticationTypes?.count {
			return count
		}
		return 0
    }
	
	
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AuthenticationCell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
		cell.textLabel?.text = authenticationTypes?[indexPath.row]

        return cell
    }
	
	func authenticate(sender:NSIndexPath) {
		if hasTouchID {
			if sender.row == 0 {
				authenticateUsingTouchID(tableView.cellForRowAtIndexPath(sender))
			} else {
				passAuthentication(sender)
			}
		} else {
			passAuthentication(sender)
		}
	}
	
	func passAuthentication(sender:NSIndexPath) {
		if hasTouchID {
			if sender.row == 1 {
				performSegueWithIdentifier("FacialSegue", sender: tableView.cellForRowAtIndexPath(sender))
			} else if sender.row == 2 {
				performSegueWithIdentifier("PasswordSegue", sender: tableView.cellForRowAtIndexPath(sender))
			} else {
				
			}
		} else {
			if sender.row == 0 {
				performSegueWithIdentifier("FacialSegue", sender: tableView.cellForRowAtIndexPath(sender))
			} else if sender.row == 1 {
				performSegueWithIdentifier("PasswordSegue", sender: tableView.cellForRowAtIndexPath(sender))
			} else {
				
			}
		}
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		authenticate(indexPath)
	}
	
	func authenticateUsingTouchID(sender:AnyObject?) {
		if hasTouchID {
			localAuthenticationContext.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: "Just Pass", reply: { (auth, error) -> Void in
				if auth {
					dispatch_async(dispatch_get_main_queue(), {self.performSegueWithIdentifier("TouchIDCredentailSegue", sender: sender)})
				} else {
					
				}
			})
		}
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "FacialSegue"  || segue.identifier == "PasswordSegue" {
			let destinationViewController = segue.destinationViewController as? CredentialViewController
//			destinationViewController
		}
		if let sender = sender as? UITableViewCell {
			let indexPath = tableView.indexPathForCell(sender)
			if hasTouchID && indexPath?.row == 0 {
				let destinationViewController = segue.destinationViewController as? CredentialViewController
			}
			
			
		}
		println(segue.destinationViewController)
	}

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
