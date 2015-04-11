//
//  UserData.swift
//  Passing Your Password
//
//  Created by Andrew Arnopoulos on 4/10/15.
//  Copyright (c) 2015 Spaghettio. All rights reserved.
//

import UIKit

class UserData: NSObject {
	var userID:NSObject?
	var credentials:[Credential] = []
	static var defaultUserData = UserData()
	
	func add(credential c:Credential) {
		credentials += [c]
	}
	
	func remove(credential c:Credential) {
		credentials = credentials.filter({c != $0})
	}
	
}

class Credential: NSObject {
	var url:String
	var userName:String
	var password:String
	
	init(url:String,userName:String, password:String) {
		self.url = url
		self.userName = userName
		self.password = password
		super.init()
	}
}
