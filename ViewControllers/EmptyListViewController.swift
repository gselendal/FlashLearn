//
//  EmptyListViewController.swift
//  FlashLearn
//
//  Created by Güldeste Selen Dal on 16.12.2019.
//  Copyright © 2019 Güldeste Selen Dal. All rights reserved.
//

import UIKit

class EmptyListViewController: UIViewController {
    var selectedCollectionId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let destination = segue.destination as! AddFlashcardViewController
        destination.selectedCollectionId = selectedCollectionId!
    }
}
