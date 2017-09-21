//
//  ViewController.swift
//  Quiz
//
//  Created by Mark Engen on 9/4/17.
//  Copyright © 2017 Mark Engen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var answerLabel: UILabel!

    let questions: [String] = [
        "What is 7 + 7?",
        "What is the capital of Vermont?",
        "What is cognac made from?"
    ]
    
    let answers: [String] = [
        "14",
        "Montpelier",
        "Grapes"
    ]
    var currentQuestionIndex: Int = 0
    
    @IBAction func showNextQuestion(_ sender: UIButton) {
        print("Starting showNextQuestion")

        currentQuestionIndex += 1
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0
        }
        
        let question: String = questions[currentQuestionIndex]
        nextQuestionLabel.text = question
        answerLabel.text = "???"
        print("\tAlpha currently \(nextQuestionLabel.alpha)")
        animateLabelTransitions()
        print("\tAlpha currently \(nextQuestionLabel.alpha)")
        print("Exiting showNextQuestion")
    }
    
    @IBAction func showAnswer(_ sender: UIButton) {
        print("Starting showAnswer")
        let answer: String = answers[currentQuestionIndex]
        answerLabel.text = answer
        print("Exiting showAnswer")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Starting viewDidLoad")
        //questionLabel.text = questions[currentQuestionIndex]
        currentQuestionLabel.text = questions[currentQuestionIndex]
        print("currentQuestionLabel.alpha =  \(currentQuestionLabel.alpha)")

        print("Exiting viewDidLoad")
        
        updateOffScreenLabel()
    }
    
    func updateOffScreenLabel() {
        let screenWidth = view.frame.width
        nextQuestionLabelCenterXConstraint.constant = -screenWidth
    }
    //This method handles animation, declares a closure constant, takes no arguments and returns no value
    func animateLabelTransitions() {
        // Force any outstanding layout changes to occur
        view.layoutIfNeeded()
        //Animate the alpha
        //and the center X constraints
        let screenWidth = view.frame.width
        self.nextQuestionLabelCenterXConstraint.constant = 0
        self.currentQuestionLabelCenterXConstraint.constant += screenWidth
        
        UIView.animate(withDuration: 0.5,
            delay: 0,
            options: [.curveLinear], /* If options blank, will ease in/out */
            animations: {
                self.currentQuestionLabel.alpha = 0
                self.nextQuestionLabel.alpha = 1
                
                self.view.layoutIfNeeded()
            },
            completion: { _ in
                print("Before swap, currentQuestionLabel.text = \(String(describing: self.currentQuestionLabel.text))")
                print("Before swap, nextQuestionLabel.text = \(String(describing: self.nextQuestionLabel.text))")
                swap(&self.currentQuestionLabel,
                     &self.nextQuestionLabel)
                swap(&self.currentQuestionLabelCenterXConstraint,
                     &self.nextQuestionLabelCenterXConstraint)
                self.updateOffScreenLabel()
                print("After swap, currentQuestionLabel.text = \(String(describing: self.currentQuestionLabel.text))")
                print("After swap, nextQuestionLabel.text = \(String(describing: self.nextQuestionLabel.text))")
        })
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Starting viewWillAppear")
        print("Alpha currently \(nextQuestionLabel.alpha)")
        nextQuestionLabel.alpha = 0
        // Set the label's initial alpha
        print("Alpha currently \(nextQuestionLabel.alpha)")

        print("Exiting viewWillAppear")
    }
 
}

