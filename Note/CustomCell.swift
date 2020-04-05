//
//  CustomCell.swift
//  Note
//
//  Created by Seyed Ali Shahrokhi on 1/16/1399 AP.
//  Copyright © 1399 Seyed Ali Shahrokhi. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet weak var LableTaskTitle: UILabel!
    @IBOutlet weak var SwitchTaskDone: UISwitch!
    
    internal var task_id:Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
