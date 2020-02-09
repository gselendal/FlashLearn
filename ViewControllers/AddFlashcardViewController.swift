//
//  CollectionDetailsViewController.swift
//  FlashLearn
//
//  Created by Güldeste Selen Dal on 16.12.2019.
//  Copyright © 2019 Güldeste Selen Dal. All rights reserved.
//

import UIKit

extension AddFlashcardViewController: AddFlashcardCellDelegate {
    func saveButtonPressed() {
        self.flashcardCollectionDataSource.createOneFlashcard(collectionID: selectedCollectionId!, frontsideText: self.frontside!, backsideText: self.backside!)
    }
}
 
extension AddFlashcardViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.flashcardCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddCell", for: indexPath) as! AddFlashcardTableViewCell
        
        cell.selectionStyle = .none
        
        Utilities.styleTextField(cell.backsideTextField)
        Utilities.styleTextField(cell.frontsideTextField)
        
        cell.cellDelegate = self
        cell.backsideTextField.delegate = self
        cell.frontsideTextField.delegate = self
        
        
        return cell
    }
    
    
    
}

class AddFlashcardViewController: UIViewController, UITextFieldDelegate {
    var selectedCollectionId: String?
    let flashcardCollectionDataSource = FlashcardCollectionDataSource()
    @IBOutlet weak var tableView: UITableView!
    var flashcardCount: Int = 1
    var frontside: String?
    var backside: String?
    
    @IBAction func setFrontside(_ sender: UITextField) {
        self.frontside = sender.text! as String
    }
    
    @IBAction func setBackside(_ sender: UITextField) {
        self.backside = sender.text! as String
    }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        insertFlashcardRow()
    }
    
    @IBAction func saveAllButtonPressed(_ sender: Any) {
        flashcardCollectionDataSource.updateCollectionCount(collectionID: selectedCollectionId!, flashcardCount: flashcardCount)
    }
    
    
    func insertFlashcardRow(){
        flashcardCount += 1
        let indexPath = IndexPath(row: flashcardCount-1, section: 0)
        
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        setCustomUI()
    }
    func setCustomUI(){
        self.view.backgroundColor = UIColor(rgb: 0x000a12)
        self.tableView.backgroundColor = UIColor(rgb: 0x000a12)
        self.title = "Create"
        navigationItem.hidesBackButton = true
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    

}
