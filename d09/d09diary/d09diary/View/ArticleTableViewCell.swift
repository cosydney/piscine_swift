//
//  ArticleTableViewCell.swift
//  d09diary
//
//  Created by Sydney COHEN on 6/8/18.
//  Copyright © 2018 Sydney COHEN. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var titre: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var creationDate: UITextField!
    @IBOutlet weak var modificationDate: UITextField!
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
