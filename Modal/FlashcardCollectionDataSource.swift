//
//  FlashcardDataSource.swift
//  FlashLearn
//
//  Created by Güldeste Selen Dal on 2.12.2019.
//  Copyright © 2019 Güldeste Selen Dal. All rights reserved.
//

import Foundation
import Firebase


protocol FlashcardCollectionDataSourceDelegate {
    func collectionListLoaded (flashcardCollectionArray: [FlashcardCollection])
    func collectionLoaded(collection: FlashcardCollection)
}

extension FlashcardCollectionDataSourceDelegate {
    func collectionListLoaded (flashcardCollectionArray: [FlashcardCollection]) { }
    func collectionLoaded(collection: FlashcardCollection) {}
}

class FlashcardCollectionDataSource {
    var delegate: FlashcardCollectionDataSourceDelegate?
    
    var ref: DatabaseReference?
    var flashcardCollectionArray: [FlashcardCollection] = []
    let userID: String?
    
    init() {
        userID = Auth.auth().currentUser?.uid
        
        ref = Database.database().reference()
    }
    
    func loadListOfFlashcardCollections() {
        
        ref?.child(userID!).observe(.value, with: { (snapshot) in
            self.flashcardCollectionArray.removeAll()
            
            for child in (snapshot.children) {
                let snap = child as! DataSnapshot
                
                let childSnapshot = snapshot.childSnapshot(forPath: snap.key)
                
                //default flashcard object is also created
                

                let collection = FlashcardCollection(snapshot: childSnapshot)
                
                self.flashcardCollectionArray.append(collection)
                
                DispatchQueue.main.async {
                    self.delegate?.collectionListLoaded(flashcardCollectionArray: self.flashcardCollectionArray)
                }
            }
            
        })
        
    }
    func updateCollectionScore(collectionID: String, score: String){
        ref?.child(userID!).child(collectionID).child("score").setValue(score)
    }
    
    func updateCollectionCount(collectionID: String, flashcardCount: Int){
    ref?.child(userID!).child(collectionID).child("flashcardCount").setValue("\(flashcardCount)")
    }
    
    /*
    func getFlashcardCollectionWithId(collectionID: String){
        ref?.child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            //got dictionary of all flashcard collections of a user
            let value = snapshot.value as! [String:AnyObject]
            //specifies one flashcardcollection with collectionID
            let collection = FlashcardCollection(flashcardCollectionDict: value[collectionID] as! [String : AnyObject])
            
        })
    }*/
    
    func deleteFlashcardCollectionAt(index: Int) {
        let id = flashcardCollectionArray[index].id
        flashcardCollectionArray.removeAll()
        let post = ref?.child(userID!).child(id)
        post?.removeValue()
        
    }
    
    func createFlashcardCollection(flashcardCollectionName: String, category: String) -> String? {
        let key = ref?.childByAutoId().key
        
        let flashcardCollection = ["id": key,
                                   "flashcardCollectionName": flashcardCollectionName, "score":"0", "category": category]
        
        ref?.child(userID!).child(key!).setValue(flashcardCollection)
        
        //create default flashcard
        let defaultFlashcard = ["frontside": "default", "backside": "default", "id": "default"]
        
        ref?.child(userID!).child(key!).child("flashcards").child("default").setValue(defaultFlashcard)
        
        return key
    }
    
    func createOneFlashcard(collectionID: String, frontsideText: String, backsideText: String){
        let key = ref?.childByAutoId().key
        
        let flashcard = ["frontside": frontsideText, "backside":backsideText, "id":key]
        ref?.child(userID!).child(collectionID).child("flashcards").child(key!).setValue(flashcard)
    }
    
    func logOut(){
        do {
            try Auth.auth().signOut()
        } catch let err {
            print(err)
        }
    }
    
}
