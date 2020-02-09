//
//  FlashcardListTableViewCell.swift
//  FlashLearn
//
//  Created by Güldeste Selen Dal on 17.12.2019.
//  Copyright © 2019 Güldeste Selen Dal. All rights reserved.
//

import UIKit

class FlashcardListTableViewCell: UITableViewCell {

    @IBOutlet weak var backsideTextView: UITextView!
    @IBOutlet weak var frontsideTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
