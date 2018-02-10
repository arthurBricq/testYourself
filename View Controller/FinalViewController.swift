//
//  FinalViewController.swift
//  testYourself
//
//  Created by Arthur BRICQ on 10/02/2018.
//  Copyright © 2018 Arthur BRICQ. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController {

    // MARK : Outlets --------------------------
    @IBOutlet weak var stackWIdth: NSLayoutConstraint!
    @IBOutlet weak var grapViewWidth: NSLayoutConstraint!
    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var backStackView: UIStackView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let delta:CGFloat = 30 // à vérifier avec la subclass de la view. Il s'agit du décalage entre la gauche du graphe (ou sa droite) et le bord de la view
        stackWIdth.constant = graphView.layer.bounds.width - delta
        updateStackView()
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func updateStackView() {
        label1.text = activeQuizz.properties[0]
        label2.text = activeQuizz.properties[1]
        label3.text = activeQuizz.properties[2]
        label4.text = activeQuizz.properties[3]
        label5.text = activeQuizz.properties[4]
        label6.text = activeQuizz.properties[5]

        stackView.sizeToFit()
        stackView.layoutIfNeeded()
        let stackHeight = stackView.bounds.height
        graphView.bottomMargin = stackHeight + 10
    }
    
    func updateTheBottomView() { /*
         Cette fonction s'occupe de la gestion de l''espace de la vue du bas qui doit être glissée vers la gauche pour revenir au menu. 
    */
        
    }
}
    


