//
//  GradeTableViewCell.swift
//  StudentManager
//
//  Created by FrozenHeart on 2019/5/24.
//  Copyright © 2019 FrozenHeart. All rights reserved.
//

import UIKit

class GradeTableCell: UITableViewCell {
    
    @IBOutlet var courseNameLabel:UILabel!
    @IBOutlet var gradeLabel:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
