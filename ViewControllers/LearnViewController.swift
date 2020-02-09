//
//  LearnViewController.swift
//  FlashLearn
//
//  Created by Güldeste Selen Dal on 22.12.2019.
//  Copyright © 2019 Güldeste Selen Dal. All rights reserved.
//

import UIKit

extension LearnViewController: LearnHelperDelegate {
    func getCollection() -> [FlashcardCollection] {
        return flashcardCollection
    }
    func setFrontTextView(text: String){
        frontsideTextView.text = text
    }
    func setBackTextView(text: String){
        backsideTextView.text = text
    }
    
}

class LearnViewController: UIViewController {
    var selectedCollectionId: String?
    var flashcardCollection: [FlashcardCollection] = []
    var learnHelper = LearnHelper()
    var correct = 0
    var total = 0
    var hasCount = false
    
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var backside: UIView?
    @IBOutlet weak var frontside: UIView?
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var thumbsImageView: UIImageView!
    @IBOutlet weak var thumbsImageView2: UIImageView!
    @IBOutlet weak var frontsideTextView: UITextView!
    @IBOutlet weak var backsideTextView: UITextView!
    @IBOutlet weak var checkResults: UIView!
    
    var divisor: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        divisor = ((view.frame.width) / 2) / 0.61
        card.addSubview(backside!)
        card.addSubview(frontside!)
        frontside?.isHidden = false
        backside?.isHidden = true
        checkResults.isHidden = true
        
        learnHelper.delegate = self
        learnHelper.initialize()
        
        drawFlashcard()
        print("came here 2")
    }
    
    @IBAction func swipeCard(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        let xFromCenter = card.center.x - view.center.x
        
        card.center = CGPoint(x: card.center.x + point.x/50, y: card.center.y + point.y/50)
        
        card.transform = CGAffineTransform(rotationAngle: xFromCenter/divisor!)
        
        if (xFromCenter > 0) {
            thumbsImageView.image = UIImage(named: "like")
            thumbsImageView2.image = UIImage(named: "like")
        } else {
            thumbsImageView.image = UIImage(named: "thumb-down" )
            thumbsImageView2.image = UIImage(named: "thumb-down" )
        }
        
        thumbsImageView.alpha = abs(xFromCenter) / view.center.x
        thumbsImageView2.alpha = abs(xFromCenter) / view.center.x
        
        if  (sender.state == UIGestureRecognizer.State.ended) {
            if (xFromCenter < -50) {
                print("WRONG")
                self.increment(isCorrect: false)
            } else if (xFromCenter > 50) {
                print("CORRECT")
                self.increment(isCorrect: true)
            }
            resetUI()
        }
    }
    
    func increment(isCorrect: Bool){
        if isCorrect {
            correct += 1
        }
        total += 1
        
        self.flashcardCollection[0].correct = correct
        self.flashcardCollection[0].total = total
    }
    
    
    func resetUI(){
        UIView.animate(withDuration: 0.2, animations: {
            self.card.center = self.view.center
            self.thumbsImageView.alpha = 0
            self.thumbsImageView2.alpha = 0
            self.card.transform = CGAffineTransform.identity
            self.drawFlashcard()
            self.card.alpha = 1
        })
    }
    
    func drawFlashcard(){
        if let flashcard = learnHelper.drawFlashcard() {
            frontsideTextView.text = flashcard.frontSide
            backsideTextView.text = flashcard.backSide
            self.frontside?.isHidden = false
            self.backside?.isHidden = true
        }
        else {
            UIView.animate(withDuration: 0.5, animations: {
                self.frontside?.isHidden = true
                self.backside?.isHidden = true
                self.checkResults.isHidden = false
            })
        }
    }
    
    @IBAction func flipCard(_ sender: UITapGestureRecognizer) {
        if backside?.isHidden == true {
            backside?.showFlip()
            frontside?.hideFlip()
        }else if frontside?.isHidden == true {
            backside?.hideFlip()
            frontside?.showFlip()
        }
    }
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "learnToResult") {
            let destination = segue.destination as!  ResultViewController
            destination.flashcardCollection = flashcardCollection
        }
    }
    
    
}

extension UIView{
    
    func showFlip(){
        if self.isHidden{
            UIView.transition(with: self, duration: 1, options: [.transitionFlipFromRight,.allowUserInteraction], animations: nil, completion: nil)
            self.isHidden = false
        }
        
    }
    func hideFlip(){
        if !self.isHidden{
            UIView.transition(with: self, duration: 1, options: [.transitionFlipFromLeft,.allowUserInteraction], animations: nil,  completion: nil)
            self.isHidden = true
        }
    }
    
    
}
