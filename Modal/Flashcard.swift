//
//  Flashcard.swift
//  FlashLearn
//
//  Created by Güldeste Selen Dal on 30.11.2019.
//  Copyright © 2019 Güldeste Selen Dal. All rights reserved.
//

import Foundation
import Firebase

struct Flashcard {
    var id: String
    var frontSide: String
    var backSide: String
    
    init(flashcard: [String:AnyObject]) {
        id = flashcard["id"] as! String
        frontSide = flashcard["frontside"] as! String
        backSide = flashcard["backside"] as! String
    }
}
