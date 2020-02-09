//
//  AddFlashcardTableViewCell.swift
//  FlashLearn
//
//  Created by Güldeste Selen Dal on 22.12.2019.
//  Copyright © 2019 Güldeste Selen Dal. All rights reserved.
//

import UIKit

protocol AddFlashcardCellDelegate {
    func saveButtonPressed()
}

class AddFlashcardTableViewCell: UITableViewCell {
    var cellDelegate: AddFlashcardCellDelegate?
    var index: IndexPath?
    var frontside: String = "Allah"
    var backside: String = "Allah"
    
    @IBOutlet weak var frontsideTextField: UITextField!
    @IBOutlet weak var backsideTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        cellDelegate?.saveButtonPressed()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
