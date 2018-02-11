//
//  ResultsTableViewController.swift
//  testYourself
//
//  Created by Marin on 11/02/2018.
//  Copyright © 2018 Arthur BRICQ. All rights reserved.
//

import UIKit
/*
let tmp1 = OneScore(name: "Arthur", gender: "Male", nameOfQuizz: "FF", scores: [0, 0, 0, 0, 0, 0])
let tmp2 = OneScore(name: "Marin", gender: "Male", nameOfQuizz: "Fjkf", scores: [40, 0, 40, 0, 40, 0])
let tmp3 = OneScore(name: "Elsa", gender: "Female", nameOfQuizz: "efe", scores: [0, 0, 40, 0, 40, 0])
var items : [OneScore] = [tmp1, tmp2, tmp3]
*/
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
        return allScores.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! ResultTableViewCell
        
        cell.nameLabel.text = allScores[indexPath.row].name
        cell.genderLabel.text = allScores[indexPath.row].gender
        cell.quizNameLabel.text = allScores[indexPath.row].nameOfQuizz
        cell.bestCategoryLabel.text = findTheGreatestCategory(atIndex: indexPath.row)
        
        return cell
    }

    
    func findTheGreatestCategory(atIndex: Int) -> String { /*
         On appelle cette fonction pour retourner le string du paramètre qui possède la score le plus élevé pour une partie, afin de l'afficher sur l'écran des résultats.
         Le paramètre d'entré représente l'index du quizz parmis tout ceux sauvegardé.
 */
        var toReturn: String = ""
        // 1) trouver la valeur maximale et son index
        let currentScore = allScores[atIndex].scores
        var maxIndex: Int = 0
        var maxValue: CGFloat = currentScore[0]
        for i in 1..<6 {
            if currentScore[i] > maxValue {
                maxValue = currentScore[i]
                maxIndex = i
            }
        }
        // 2) trouver le quizz en question grâce à son titre, et extraire le nom de la propriété maximale.
        let nameOfQuizz = allScores[atIndex].nameOfQuizz
        
        for tmpQuizz in allQuizz {
            if tmpQuizz.title == nameOfQuizz {
                toReturn = tmpQuizz.properties[maxIndex]
            }
        }
        
        return toReturn
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
