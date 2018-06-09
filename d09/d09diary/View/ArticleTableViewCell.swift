//
//  ArticleTableViewCell.swift
//  d09diary
//
//  Created by Sydney COHEN on 6/8/18.
//  Copyright © 2018 Sydney COHEN. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var creationDate: UILabel!
    @IBOutlet weak var modificationDate: UILabel!
    @IBOutlet weak var titre: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var descriptionLabel: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
