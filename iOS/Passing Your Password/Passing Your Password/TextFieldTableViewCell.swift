//
//  TextFieldTableViewCell.swift
//  Passing Your Password
//
//  Created by Andrew Arnopoulos on 4/11/15.
//  Copyright (c) 2015 Spaghettio. All rights reserved.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {

	@IBOutlet var textField:UITextField?
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
