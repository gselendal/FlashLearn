//
//  ResultViewController.swift
//  FlashLearn
//
//  Created by Güldeste Selen Dal on 19.12.2019.
//  Copyright © 2019 Güldeste Selen Dal. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    var flashcardCollection: [FlashcardCollection] = []
    var flashcardCollectionDataSource = FlashcardCollectionDataSource()
    var correct = 0
    var total = 0
    
    @IBOutlet weak var flashcardCollectionName: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(flashcardCollection[0].flashcardCollectionName)
        print(flashcardCollection[0].correct)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        show()
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true) {
        }
    }
    
    
    func show(){
        
        flashcardCollectionName.text = flashcardCollection[0].flashcardCollectionName
        
        let correct = flashcardCollection[0].correct
        let total = flashcardCollection[0].total
        let scorePercentage = (Double(correct) / Double(total))*100
        
        scoreLabel.text = "\(correct)"
        totalLabel.text = "\(total)"
        
        if (scorePercentage >= 75.0){
            self.scoreLabel.textColor = UIColor.green
        } else  {
            self.scoreLabel.textColor = UIColor.red
        }
        self.flashcardCollection[0].scorePercentage = scorePercentage
       
        flashcardCollectionDataSource.updateCollectionScore(collectionID: flashcardCollection[0].id, score: "\(scorePercentage)")
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
    }
    
    
}
