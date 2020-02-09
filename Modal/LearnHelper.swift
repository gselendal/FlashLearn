//
//  LearnHelper.swift
//  FlashLearn
//
//  Created by Güldeste Selen Dal on 23.12.2019.
//  Copyright © 2019 Güldeste Selen Dal. All rights reserved.
//

import Foundation

protocol LearnHelperDelegate {
    func getCollection() -> [FlashcardCollection]
    func setFrontTextView(text: String)
    func setBackTextView(text: String)
}

class LearnHelper {
    var flashcardCollection: [FlashcardCollection] = []
    var flashcardCollectionDataSource = FlashcardCollectionDataSource()
    var delegate: LearnHelperDelegate?
    var correct: Int = 0
    var total: Int = 0
    
    func drawFlashcard() -> Flashcard? {
        if (flashcardCollection[0].flashcardArray.count != 0){
           return flashcardCollection[0].flashcardArray.popLast()
        }
        return nil
    }
    
    func initialize(){
        print(flashcardCollection)
        flashcardCollection = (self.delegate?.getCollection())!
        flashcardCollection[0].flashcardArray.shuffle()
    }
    
    func increment(isCorrect: Bool){
        if isCorrect {
            correct += 1
        }
        
        total += 1
    }
}
