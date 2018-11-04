//
//  MedalsTableViewCell.swift
//  DeskPotatoes
//
//  Created by Terrell, Joshua on 11/1/18.
//  Copyright © 2018 Darren Powers. All rights reserved.
//

import UIKit

class MedalsTableViewCell: UITableViewCell {

    var myCustomViewController: MedalTableViewController = MedalTableViewController()
    
    @IBOutlet weak var medal1des: UILabel!
    
    var medalName: String = "Locked"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if myCustomViewController.testThis == true {
            print("testThis var worked!")
            medalName = "Unlocked"
        } else {
            print(myCustomViewController.testThis)
            medalName = "Locked"
        }
        
        medal1des.text = medalName
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
