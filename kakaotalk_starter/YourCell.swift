//
//  YourCell.swift
//  kakaotalk_starter
//
//  Created by home on 2020/10/14.
//  Copyright © 2020 James Kim. All rights reserved.
//

import UIKit

class YourCell: UITableViewCell {

    @IBOutlet weak var inputTextField: UITextView!
    @IBOutlet weak var yourImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
