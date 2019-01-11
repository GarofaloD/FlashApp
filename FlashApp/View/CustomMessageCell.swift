//
//  CustomMessageCell.swift
//  FlashApp
//
//  Created by Daniel Garofalo on 1/9/19.
//  Copyright © 2019 Daniel Garofalo. All rights reserved.
//

import UIKit

class CustomMessageCell: UITableViewCell {

    //MARK:- Outlets
    @IBOutlet weak var messageBackground: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var messageBody: UILabel!
    @IBOutlet weak var senderUserName: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    
}
