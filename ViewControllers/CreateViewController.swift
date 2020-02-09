//
//  CreateViewController.swift
//  FlashLearn
//
//  Created by Güldeste Selen Dal on 2.12.2019.
//  Copyright © 2019 Güldeste Selen Dal. All rights reserved.
//

import UIKit
import Firebase


class CreateViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    
    @IBAction func createFlashcardCollection(_ sender: Any) {
        collectionId = flashcardCollectionDataSource.createFlashcardCollection(flashcardCollectionName: nameTextField.text! as String, category: categoryTextField.text! as String)
        
    }
    
    var flashcardCollectionDataSource = FlashcardCollectionDataSource()
    var collectionId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomUI()
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    func setCustomUI(){
        self.view.backgroundColor = UIColor(rgb: 0x000a12)
        self.title = "Create"
        Utilities.styleTextField(nameTextField!)
        Utilities.styleTextField(categoryTextField!)
        navigationItem.hidesBackButton = true
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "collectionToFlashcard") {
            let destination = segue.destination as! AddFlashcardViewController
            destination.selectedCollectionId = collectionId!
        }
    }
    
    
}
