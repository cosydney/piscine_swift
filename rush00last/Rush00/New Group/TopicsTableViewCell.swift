//
//  TopicsTableViewCell.swift
//  Rush00
//
//  Created by Sydney COHEN on 6/2/18.
//  Copyright © 2018 Jean-christophe BLONDEAU. All rights reserved.
//

import UIKit

class TopicsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
