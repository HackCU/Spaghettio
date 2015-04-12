//
//  UserData.swift
//  Passing Your Password
//
//  Created by Andrew Arnopoulos on 4/10/15.
//  Copyright (c) 2015 Spaghettio. All rights reserved.
//

import UIKit

@objc public class UserData: NSObject {
	var userID:NSString?
	var credentials:[Credential] = []
	static var defaultUserData = UserData()
	
	func add(credential c:Credential) {
		credentials += [c]
	}
	
	func remove(credential c:Credential) {
		credentials = credentials.filter({c != $0})
	}
	
	func removeAll() {
		credentials = []
	}
	
}