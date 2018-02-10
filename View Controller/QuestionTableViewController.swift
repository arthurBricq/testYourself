//
//  QuestionTableViewController.swift
//  testYourself
//
//  Created by Arthur BRICQ on 05/02/2018.
//  Copyright © 2018 Arthur BRICQ. All rights reserved.
//

import UIKit

class QuestionTableViewController: UITableViewController, TableViewCellDelegate
{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
        initialize_OneQuizzChecked()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        let tmp = activeQuizz.allQuestions[activeQuestionIdentifier].answers.count
        return tmp
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! AnswerTableViewCell
        
        let tmpSection = indexPath.section // Is the number of the answer index (...For each rows...)
        let currentQuestion = activeQuizz.allQuestions[activeQuestionIdentifier] // Is the current question
        
        // Updating the textField (which is actually a Label)
        let textToDisplay = currentQuestion.answers[tmpSection]
        cell.textField.text = textToDisplay.answer
        cell.textField.sizeToFit()
        
        // Updating the buttons :
        var buttonImage = UIImage()
        let section = indexPath.section
        if OneQuizzChecked[activeQuestionIdentifier].isChecked[section] {
            buttonImage = UIImage(named: "checkBox")!
        } else {
            buttonImage = UIImage(named: "uncheckBox")!
        }
        
        cell.button.setImage(buttonImage, for: .normal)
        
        cell.delegate = self
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    
    
    // Buttons actions & logic
    func userDidTapButton(_ sender: AnswerTableViewCell)
    {
        /*
         Cette fonction est appelée quand l'utilisateur tappe sur un boutton.
        */
        guard let tappedIndexPath = tableView.indexPath(for: sender) else { return }
        let sectionTapped = tappedIndexPath.section
        print("La section tappée est : \(sectionTapped)")
        updateCheckedArray(forButtonInSection: sectionTapped)
        self.tableView.reloadData()
        
        // Recharger les données.
        var tmpIndexPath = IndexPath()
        let sectionNumber = activeQuizz.allQuestions[activeQuestionIdentifier].answers.count-1
        for i in 0...sectionNumber {
            let rowNumber = 0
            tmpIndexPath = IndexPath(row: rowNumber, section: i)
            tableView(self.tableView, cellForRowAt: tmpIndexPath)

        }
    }
}

func updateCheckedArray(forButtonInSection: Int)
{
    let numberOfAnswers = activeQuizz.allQuestions[activeQuestionIdentifier].answers.count
    // One verification of the logic
    if numberOfAnswers != OneQuizzChecked[activeQuestionIdentifier].isChecked.count {
        fatalError("There is a incoherence inside the different arrays.")
    }
    // Changing the previous result (if there is one, because we only can choose one correct answer)
    for i in 0...numberOfAnswers-1 {
        if OneQuizzChecked[activeQuestionIdentifier].isChecked[i] { // the answer number i is checked
            if i != forButtonInSection { // The answer number i is not the one that the user tapped just now
                OneQuizzChecked[activeQuestionIdentifier].isChecked[i] = false // Then it becomes false.
            }
        }
    }
    
    OneQuizzChecked[activeQuestionIdentifier].isChecked[forButtonInSection] = true ;
    describe_OneQuizzChecked()
}

