//
//  CollectionDetailViewController.swift
//  FlashLearn
//
//  Created by Güldeste Selen Dal on 14.12.2019.
//  Copyright © 2019 Güldeste Selen Dal. All rights reserved.
//

import UIKit

class CollectionDetailViewController: UIViewController {
    var selectedCollectionId: String?
    
    @IBOutlet weak var frontsideTextView: UITextView!
    @IBOutlet weak var backsideTextView: UITextView!
    
    @IBAction func saveFlashcard(_ sender: Any) {
        writeHelper.createOneFlashcard(collectionID: selectedCollectionId!, frontsideText: frontsideTextView.text, backsideText: backsideTextView.text)
    }
    
    var writeHelper = WriteHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
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
