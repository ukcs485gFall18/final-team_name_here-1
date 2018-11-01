//
//  MedalsTableViewCell.swift
//  DeskPotatoes
//
//  Created by Terrell, Joshua on 11/1/18.
//  Copyright © 2018 Darren Powers. All rights reserved.
//

import UIKit

class MedalsTableViewCell: UITableViewCell {

    @IBOutlet weak var medal1: UILabel!
    @IBOutlet weak var medal1des: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
