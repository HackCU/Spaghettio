//
//  CredentialOverviewTableViewController.swift
//  Passing Your Password
//
//  Created by Andrew Arnopoulos on 4/10/15.
//  Copyright (c) 2015 Spaghettio. All rights reserved.
//

import UIKit

class CredentialOverviewTableViewController: UITableViewController {
	
	var userData = UserData()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
//		userData.add(credential: Credential(url: "netflix.com", userName: "Andrew", password: "1234"))
//		userData.add(credential: Credential(url: "facebook.com", userName: "Swisher", password: "password"))
    }
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
//		UserData.defaultUserData = UserData()
//		var userData = UserData.defaultUserData
		
//		NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
//		request.HTTPMethod = @"POST";
//		request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://ec2-54-69-170-52.us-west-2.compute.amazonaws.com:8080/%@/dickpic",@"noah"]];
//		var request = NSMutableURLRequest()
//		request.HTTPMethod = "GET"
//		request.URL = NSURL(string: "http://ec2-54-69-170-52.us-west-2.compute.amazonaws.com:8080/noah/credentials")
//		NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {println("hello \($0.0)")}
		
		userData.removeAll()
		
		let request = NSURLRequest(URL: NSURL(string: "http://ec2-54-69-170-52.us-west-2.compute.amazonaws.com:8080/noah/credentials")!)
		var error:NSError?
		let jsonData = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: &error)!
		let json = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as! NSDictionary
		
		for value in (json["all"] as! [AnyObject]) {
			if let value = value as? [String:[String:String]] {
				println(value)
				for (k,v) in value {
					if k != "_id" {
						let cred = Credential(url: k, userName: v["user"]!, password: v["password"]!, temporary: false)
						userData.add(credential: cred)
					}
				}
			}
			
		}
		
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
