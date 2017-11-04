//
//  Club.swift
//  MyClubs
//
//  Created by Korman Chen on 11/3/17.
//  Copyright © 2017 Korman Chen. All rights reserved.
//

import Foundation
import UIKit

class Club {
    var clubName : String
    var clubImage : UIImage?
    
    init() {
        clubName = ""
        clubImage = UIImage(named: "")
    }
    
    convenience init(name: String) {
        self.init()
        clubName = name
    }
    
    convenience init(name: String, image: UIImage) {
        self.init()
        clubName = name
        clubImage = image
    }
}
