//
//  TableViewCell.swift
//  Enlisted
//
//  Created by Monika on 2017-08-30.
//  Copyright © 2017 Monika. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var vacationCellLocationName: UILabel!
    @IBOutlet weak var vacationCellImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
