//
//  FilmTableViewCell.swift
//  d02tableview
//
//  Created by Sydney COHEN on 5/29/18.
//  Copyright © 2018 Sydney COHEN. All rights reserved.
//

import UIKit

class FilmTableViewCell: UITableViewCell {
    
    var film : (String, Int)? {
        didSet {
            if let f = film {
                yearLabel?.text = String(f.1)
                nameLabel?.text = f.0
            }
        }
    }
    
}

