//
//  HomeViewController.swift
//  FlashLearn
//
//  Created by Güldeste Selen Dal on 30.11.2019.
//  Copyright © 2019 Güldeste Selen Dal. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {
    var page: Int =  -1
    var isLoggedOut = false
    var flashcardCollectionDataSource = FlashcardCollectionDataSource()
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setCustomUI()
    }
    
    
    func setCustomUI(){
        self.view.backgroundColor = UIColor(rgb: 0x000a12)
        self.title = "HOME"
        view1.layer.cornerRadius = 10
        view2.layer.cornerRadius = 10
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func handleLogOut(_ sender: UIBarButtonItem) {
        flashcardCollectionDataSource.logOut()
        navigationController?.popViewController(animated: true)
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
