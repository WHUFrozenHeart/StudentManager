//
//  StudentTableCell.swift
//  StudentManager
//
//  Created by FrozenHeart on 2019/5/22.
//  Copyright © 2019 FrozenHeart. All rights reserved.
//

import UIKit

class StudentTableCell: UITableViewCell {
    
    @IBOutlet var studentNameLabel:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
