//
//  CollectionListViewController.swift
//  FlashLearn
//
//  Created by Güldeste Selen Dal on 13.12.2019.
//  Copyright © 2019 Güldeste Selen Dal. All rights reserved.
//

import UIKit

extension CollectionListViewController: FlashcardCollectionDataSourceDelegate {
    func collectionListLoaded (flashcardCollectionArray: [FlashcardCollection]) {
        self.collectionArray = flashcardCollectionArray
        self.collectionTableView.reloadData()
    }
    func collectionLoaded(collection: FlashcardCollection){
        for i in 1...self.collectionArray.count {
            if (collection.id == self.collectionArray[i].id){
                self.collectionArray[i] = collection
            }
        }
        self.collectionTableView.reloadData()
    }
}


extension CollectionListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        senderID = self.collectionArray[indexPath.row].id
        senderFlashcardCollection = self.collectionArray[indexPath.row]
        
        if (self.collectionArray[indexPath.row].flashcardArray.count == 0){
            self.performSegue(withIdentifier: "collectionListToEmpty", sender: nil)
        }
        else {
            self.performSegue(withIdentifier: "collectionListToNotEmpty", sender: nil)
        }
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.collectionArray.remove(at: indexPath.row)
            self.flashcardCollectionDataSource.deleteFlashcardCollectionAt(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }

        let learnAction = UITableViewRowAction(style: .destructive, title: "Learn") { (action, indexPath) in
            self.senderFlashcardCollection = self.collectionArray[indexPath.row]
            self.senderID = self.collectionArray[indexPath.row].id
            self.performSegue(withIdentifier: "learnButtonPressed", sender: nil)
        }
        
        learnAction.backgroundColor = UIColor(red: 0/255, green: 200/255, blue: 0/255, alpha: 1)
        
        
        return [deleteAction, learnAction]
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.collectionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! CollectionListTableViewCell
        
        let collection = self.collectionArray[indexPath.row]
        
        /*
        if (collection.scorePercentage > 0){
            if (collection.scorePercentage > 75.0){
                cell.backgroundColor = UIColor.green
            } else {
                cell.backgroundColor = UIColor.red
            }
        }*/
        
        cell.nameLabel.text = collection.flashcardCollectionName
        cell.scoreLabel.text = "\(collection.scorePercentage)%"
        return cell
    }
    
    
}

class CollectionListViewController: UIViewController {
    var senderID: String = ""
    var senderFlashcardCollection = FlashcardCollection(flashcardCollectionName: "default", id: "default")
    var flashcardCount: String?
    
    
    @IBOutlet weak var collectionTableView: UITableView!
    
    let flashcardCollectionDataSource = FlashcardCollectionDataSource()
    var collectionArray: [FlashcardCollection] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flashcardCollectionDataSource.delegate = self
        
        flashcardCollectionDataSource.loadListOfFlashcardCollections()
        
        setCustomUI()
        
        // Do any additional setup after loading the view.
    }
    
    func setCustomUI(){
        self.view.backgroundColor = UIColor(rgb: 0x000a12)
        self.title = ""
        self.collectionTableView.backgroundColor = UIColor(rgb: 0x000a12)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
          if (segue.identifier == "collectionListToNotEmpty") {
            let destination = segue.destination as!  FlashcardListViewController
            destination.selectedCollectionId = senderID
            destination.flashcardArray = senderFlashcardCollection.flashcardArray
        } else if (segue.identifier == "learnButtonPressed"){
            let destination = segue.destination as! LearnViewController
            destination.selectedCollectionId = senderID
            destination.flashcardCollection = [senderFlashcardCollection]
        }
    }
}





