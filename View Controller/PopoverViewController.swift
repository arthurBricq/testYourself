//
//  PopoverViewController.swift
//  testYourself
//
//  Created by Marin on 12/02/2018.
//  Copyright © 2018 Arthur BRICQ. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK : Outlets
    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackViewWidth: NSLayoutConstraint!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    var quizz: OneQuizz = OneQuizz(title: "", allQuestios: [], properties: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // update the stack view
        stackViewWidth.constant = graphView.layer.bounds.width - 10
        
        label1.text = quizz.properties[0]
        label2.text = quizz.properties[1]
        label3.text = quizz.properties[2]
        label4.text = quizz.properties[3]
        label5.text = quizz.properties[4]
        label6.text = quizz.properties[5]
        
        stackView.sizeToFit()
        stackView.layoutIfNeeded()
        let stackHeight = stackView.bounds.height
        graphView.bottomMargin = stackHeight + 10
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
