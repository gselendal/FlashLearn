//
//  FlashcardCollection.swift
//  FlashLearn
//
//  Created by Güldeste Selen Dal on 13.12.2019.
//  Copyright © 2019 Güldeste Selen Dal. All rights reserved.
//

import Foundation
import Firebase

struct FlashcardCollection {
    var flashcardCollectionName: String
    var id: String
    var flashcardArray: [Flashcard] = []
    var correct: Int = 0
    var total: Int = 0
    var scorePercentage: Double = 0
    var category: String = ""
    var flashcardCount: Int = 0
    var ref: DatabaseReference?
    
    init(flashcardCollectionName: String, id: String){
        self.flashcardCollectionName = flashcardCollectionName
        self.id = id
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        
        flashcardCollectionName = snapshotValue["flashcardCollectionName"] as! String
        id = snapshotValue["id"] as! String
        category = snapshotValue["category"] as! String
        let score = snapshotValue["score"] as! String
        scorePercentage = (Double(score)!).rounded()
        //create flashcard object from corresponding snapshots in "flashcards"
        
        if (snapshotValue["flashcards"] != nil)  {
            let flashcardDictionary = snapshotValue["flashcards"] as! [String:AnyObject]
            
            for key in flashcardDictionary.keys {
                if (key != "default"){
                    let flashcard = Flashcard(flashcard: flashcardDictionary[key] as! [String : AnyObject])
                    flashcardArray.append(flashcard)
                }
            }
        }
    }
    
    init(flashcardCollectionDict: [String: AnyObject]){
        flashcardCollectionName = flashcardCollectionDict["flashcardCollectionName"] as! String
        id = flashcardCollectionDict["id"] as! String
        let score = flashcardCollectionDict["score"] as! Int
        scorePercentage = (Double(score)).rounded()
        //create flashcard object from corresponding snapshots in "flashcards"
        let flashcardDictionary = flashcardCollectionDict["flashcards"] as! [String:AnyObject]
        for key in flashcardDictionary.keys {
            if (key != "default"){
                let flashcard = Flashcard(flashcard: flashcardDictionary[key] as! [String : AnyObject])
                flashcardArray.append(flashcard)
            }
        }
        
    }
    
}

