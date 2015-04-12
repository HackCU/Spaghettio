//
//  AddCredentialViewController.swift
//  Passing Your Password
//
//  Created by Andrew Arnopoulos on 4/11/15.
//  Copyright (c) 2015 Spaghettio. All rights reserved.
//

import UIKit

class AddCredentialViewController: UITableViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return 3
    }
	
	let tableCellNames = ["URL","Username","Password"]
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CredentialItemCell", forIndexPath: indexPath) as! TextFieldTableViewCell

        // Configure the cell...
		cell.textField?.placeholder = tableCellNames[indexPath.row]
		cell.textField?.delegate = self
		
        return cell
    }
	
	@IBAction func cancelAdditionOfCredential() {
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	@IBAction func completeAdditionOfCredential() {
		//Add JSON code
		let urlCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! TextFieldTableViewCell
		let usernameCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as! TextFieldTableViewCell
		let passwordCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0)) as! TextFieldTableViewCell
		
		let url = urlCell.textField?.text
		let username = usernameCell.textField?.text
		let password = passwordCell.textField?.text
		
//		NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
//		request.HTTPMethod = @"POST";
//		request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://ec2-54-69-170-52.us-west-2.compute.amazonaws.com:8080/%@/dickpic",@"noah"]];
//		[request setValue:@"image/jpeg" forHTTPHeaderField:@"Content-Type"];
//		NSString * content = [NSString stringWithFormat:@"form-data; name = \"data\"; filename=\"%@\"",photoName];
//		[request setValue:content forHTTPHeaderField:@"Content-Disposition"];
//		//Content-Disposition: form-data; name = "data"; filename="<file>"
//		counter++;
//		[request setHTTPBody:imageData];
//		NSLog(@"%@",request);
//		//				NSURLConnection * connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//		[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//		NSLog(@"Hello");
//		//					[self performSegueWithIdentifier:@"FacialCredentialSegue" sender:self];
//		//
//		//					dispatch_async(dispatch_get_main_queue(), ^{
//		//
//		//					});
//		}];
		
		let request = NSMutableURLRequest(URL: NSURL(string: "http://ec2-54-69-170-52.us-west-2.compute.amazonaws.com:8080/noah/credentials")!)
		request.HTTPMethod = "POST"
		let json = "{\"\(url!)\":{\"user\":\"\(username!)\",\"password\":\"\(password!)\"}}"
		println(json)
		request.HTTPBody = json.dataUsingEncoding(0, allowLossyConversion: false)
//		let connection = NSURLConnection(request: request, delegate: self)
		NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (r, d, e) -> Void in
			dispatch_async(dispatch_get_main_queue(), {self.dismissViewControllerAnimated(true, completion: nil)})
			println(e)
		}
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
