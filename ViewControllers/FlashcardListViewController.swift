//
//  NotEmptyListViewController.swift
//  FlashLearn
//
//  Created by Güldeste Selen Dal on 17.12.2019.
//  Copyright © 2019 Güldeste Selen Dal. All rights reserved.
//

import UIKit


extension FlashcardListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.flashcardArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FListCell", for: indexPath) as! FlashcardListTableViewCell
                
        cell.frontsideTextView.text = self.flashcardArray[indexPath.row].frontSide
        cell.backsideTextView.text = self.flashcardArray[indexPath.row].backSide
        
        return cell
    }
    
    
}
class FlashcardListViewController: UIViewController {
    var selectedCollectionId: String?
    var flashcardArray: [Flashcard] = []
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var fListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setCustomUI()
    }
    
    func setCustomUI(){
        self.tableView.backgroundColor = UIColor(rgb: 0x000a12)
        self.view.backgroundColor = UIColor(rgb: 0x000a12)
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
        self.title = "Flashcards"
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
