//
//  ClubTableViewCell.swift
//  MyClubs
//
//  Created by Korman Chen on 11/3/17.
//  Copyright © 2017 Korman Chen. All rights reserved.
//

import UIKit

class ClubTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var clubImage: UIImageView!
    @IBOutlet weak var clubNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
