//
//  ResultsTableViewController.swift
//  testYourself
//
//  Created by Marin on 11/02/2018.
//  Copyright © 2018 Arthur BRICQ. All rights reserved.
//

import UIKit

let tmp1 = OneScore(name: "Arthur", gender: "Male", nameOfQuizz: "FF", scores: [0, 0, 0, 0, 0, 0])
let tmp2 = OneScore(name: "Marin", gender: "Male", nameOfQuizz: "Fjkf", scores: [40, 0, 40, 0, 40, 0])
let tmp3 = OneScore(name: "Elsa", gender: "Female", nameOfQuizz: "efe", scores: [0, 0, 40, 0, 40, 0])

var items : [OneScore] = [tmp1, tmp2, tmp3]

class ResultsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! ResultTableViewCell
        
        cell.nameLabel.text = items[indexPath.row].name
        cell.genderLabel.text = items[indexPath.row].gender
        cell.quizNameLabel.text = items[indexPath.row].nameOfQuizz
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
