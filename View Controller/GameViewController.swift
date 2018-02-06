//
//  GameViewController.swift
//  testYourself
//
//  Created by Arthur BRICQ on 05/02/2018.
//  Copyright © 2018 Arthur BRICQ. All rights reserved.
//

import UIKit

class GameViewController: UIViewController
{
    // MARK : Outlets
    @IBOutlet var globalView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cardHeigh: NSLayoutConstraint!
    @IBOutlet weak var carWidth: NSLayoutConstraint!
    @IBOutlet weak var verticalCardCenter: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var tableViewWidth: NSLayoutConstraint!
    @IBOutlet weak var tableView: UIView!
    @IBOutlet var progressionLabelWidth: NSLayoutConstraint!
    
    
    // MARK : variables
    let gradient = CAGradientLayer()
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Creating the gradient :
        var expension = CGAffineTransform()
        expension.a = 3
        expension.d = 2
        expension.tx = -100
        expension.ty = -150
        print(expension)
        gradient.frame = globalView.frame.applying(expension)
        print(gradient.frame)
        let myColor = UIColor(red: 255/255, green: 168/255, blue: 52/255, alpha: 0.7)
        gradient.colors = [ myColor.cgColor , UIColor.clear.cgColor]
        gradient.transform = CATransform3DMakeRotation(0*CGFloat.pi / 12, 0, 0, 1)
        globalView.layer.insertSublayer(gradient, at: 0)
        
        // Arranging the card view as we want :
        // 1) The card view layer
        cardHeigh.constant = globalView.frame.height*0.8
        carWidth.constant = globalView.frame.width*0.9
        cardView.layer.cornerRadius = 20
        progressionLabelWidth.constant = carWidth.constant
        // 2) The title label
        titleLabel.text = "Question number 1"
        titleLabel.textColor = cardView.backgroundColor?.withAlphaComponent(1)
        // 3) The text field.
        textView.backgroundColor = UIColor.white.withAlphaComponent(0)
        textView.isUserInteractionEnabled = false
        // 4) Setting the table view.
        tableViewWidth.constant = carWidth.constant - 20
        tableView.backgroundColor = UIColor.clear
        // 5) Update the text view :
        updateTextView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func updateTextView() {
        textView.text = activeQuizz.allQuestions[activeQuestionIdentifier].questionLabel
    }
    


}
