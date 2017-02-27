//
//  ViewController.swift
//  Quiz
//
//  Created by Devin Smaldore on 1/18/17.
//  Copyright © 2017 Devin Smaldore. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
    
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    
    @IBOutlet var answerLabel: UILabel!
    
    var screenWidth: CGFloat!
    
//    let currentQlayout = UILayoutGuide()
//    let nextQlayout = UILayoutGuide()
    
    let questions = [
        "From what is cognac made?",
        "What is 7+7?",
        "What is the capital of Vermont?"
    ]
    let answers = [
        "Grapes",
        "14",
        "Montpelier"
    ]
    
    var currentQuestionIndex = 0
    //to make sure the answers show up at the right time
    var counter = 0
    
    @IBAction func showNextQuestion(_ sender: AnyObject) {
        currentQuestionIndex += 1
        counter += 1
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0
        }
        
        let question = questions[currentQuestionIndex]
        nextQuestionLabel.text = question
        answerLabel.text = "???"
        
        animateLabelTransitions()
    }
    
    @IBAction func showAnswer(_ sender: AnyObject) {
        let answer = answers[currentQuestionIndex]
        //basically, if my counter is odd, I want to show the answer
        if counter % 2 != 0 {
            answerLabel.text = answer
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenWidth = view.frame.width
        
        currentQuestionLabel.text = questions[currentQuestionIndex]
        
       //  Silver Challenge
        
        let space1 = UILayoutGuide()
        self.view.addLayoutGuide(space1)
        space1.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        currentQuestionLabel.leadingAnchor.constraint(equalTo: space1.trailingAnchor).isActive = true
        currentQuestionLabel.trailingAnchor.constraint(equalTo: space1.leadingAnchor).isActive = true
        
        updateOffScreenLabel()
    }
    
    
    
    func animateLabelTransitions() {
        
        //Force any outstanding layout changes to occur
        view.layoutIfNeeded()
        
        //center the X constraints
        //let screenWidth = view.frame.width
        self.nextQuestionLabelCenterXConstraint.constant = 0
        self.currentQuestionLabelCenterXConstraint.constant += screenWidth
        
        //animate the alpha
        
        UIView.animate(withDuration: 0.25,
                       delay: 0,
                       usingSpringWithDamping: 0.4, //spring animation
                       initialSpringVelocity: 0.35, //spring animation
                       options: [.curveLinear],
                       
                       animations: {
                        self.currentQuestionLabel.alpha = 0.5
                        self.nextQuestionLabel.alpha = 0.5
                        
                        self.view.layoutIfNeeded()
        },
                       
                       
                       completion: { _ in
                        swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
                        swap(&self.currentQuestionLabelCenterXConstraint, &self.nextQuestionLabelCenterXConstraint)
                        
                        self.updateOffScreenLabel()
        })
        /*
        UIView.animate(withDuration: 0.5,
                       delay: 0.5,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.5,
                       options: UIViewAnimationOptions.curveEaseOut,
                       animations: {
                        self.currentQuestionLabel.alpha = 0
                        self.nextQuestionLabel.alpha = 1
                        
                        self.view.layoutIfNeeded()
        })*/
 
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set the label's initial alpha
        nextQuestionLabel.alpha = 0
    }
    
    func updateOffScreenLabel() {
        print("in updateOffScreenLabel")
        //let screenWidth = view.frame.width
        nextQuestionLabelCenterXConstraint.constant = -screenWidth*2
    }
}



