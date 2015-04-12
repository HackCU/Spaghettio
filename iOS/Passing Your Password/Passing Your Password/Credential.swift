//
//  Credential.swift
//  Passing Your Password
//
//  Created by Andrew Arnopoulos on 4/11/15.
//  Copyright (c) 2015 Spaghettio. All rights reserved.
//

import UIKit

@objc public class Credential: NSObject {
	var url:String
	var userName:String
	var password:String
	var temporary:Bool
	
	init(url:String,userName:String, password:String,temporary:Bool = false) {
		self.url = url
		self.userName = userName
		self.password = password
		self.temporary = temporary
		super.init()
	}
}