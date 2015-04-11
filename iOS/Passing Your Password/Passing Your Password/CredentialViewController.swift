//
//  CredentialViewController.swift
//  Passing Your Password
//
//  Created by Andrew Arnopoulos on 4/11/15.
//  Copyright (c) 2015 Spaghettio. All rights reserved.
//

import UIKit

class CredentialViewController: UIViewController {
	
	var credential:Credential! {
		didSet {
			navigationItem.title = credential.url
			userNameLabel?.text = credential.userName
			passwordLabel?.text = credential.password
		}
	}
	
	@IBOutlet private var userNameLabel:UILabel?
	@IBOutlet private var passwordLabel:UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
		navigationItem.title = credential.url
		userNameLabel?.text = credential.userName
		passwordLabel?.text = credential.password
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
