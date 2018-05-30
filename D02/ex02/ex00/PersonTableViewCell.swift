//
//  PersonTableViewCell.swift
//  ex00
//
//  Created by Sydney COHEN on 5/30/18.
//  Copyright © 2018 Sydney COHEN. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    var person : Person? 

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    func setLabels()
    {
        self.nameLabel.text = self.person?.name
        self.descriptionLabel.text = self.person!.description
        self.dateLabel.text = self.person?.date.description
    }

}
