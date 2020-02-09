//
//  MainPageViewController.swift
//  FlashLearn
//
//  Created by Güldeste Selen Dal on 30.11.2019.
//  Copyright © 2019 Güldeste Selen Dal. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {
    let flashcardCollectionDataSource = FlashcardCollectionDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flashcardCollectionDataSource.loadListOfFlashcardCollections()
        // Do any additional setup after loading the view.
        setCustomUI()
    }
    
    func setCustomUI(){
        self.view.backgroundColor = UIColor(rgb: 0x000a12)
        self.title = ""
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
