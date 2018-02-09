//
//  BricqBrosViewController.swift
//  testYourself
//
//  Created by Arthur BRICQ on 08/02/2018.
//  Copyright © 2018 Arthur BRICQ. All rights reserved.
//

import UIKit

class BricqBrosViewController: UIViewController {

    // MARK : outlets
    @IBOutlet var globalView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var bricqLabel: UILabel!
    @IBOutlet weak var brosLabel: UILabel!
    @IBOutlet weak var initiativeTextLabel: UILabel!
    @IBOutlet weak var inspirativeTextLabel: UILabel!
    @IBOutlet weak var futuristTextLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var bricqConstraint: NSLayoutConstraint!
    @IBOutlet weak var brosConstraint: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTheBackground()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareForAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !isInSegueFromMenuToBricqBros {
            animateTheView()
        }
    }
    
    func prepareForAnimation() {
        stackView.alpha = 0
        backButton.alpha = 0
        bricqLabel.isHidden = true
        brosLabel.isHidden = true
        
        initiativeTextLabel.alpha = 0
        inspirativeTextLabel.alpha = 0
        futuristTextLabel.alpha = 0
        
        bricqConstraint.constant = -100
        brosConstraint.constant = -100
        self.view.layoutIfNeeded()
    }
    
    func animateTheView() {
        
        bricqLabel.isHidden = false
        brosLabel.isHidden = false
        
        UIView.animateKeyframes(withDuration: 12, delay: 0, options: .calculationModeLinear, animations: {
            
            // fait descendre le texte ".bros"
            self.brosConstraint.constant = 180
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.1, animations: {
                self.view.layoutIfNeeded()
            })
            
            // puis celui "bricq"
            self.bricqConstraint.constant = 100
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.1, animations: {
                self.view.layoutIfNeeded()
            })
            
            // fait apparaitre puis disparaitre "be inspirative"
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.1, animations: {
                self.inspirativeTextLabel.alpha = 1
                self.inspirativeTextLabel.layoutIfNeeded()
                self.view.layoutIfNeeded()
            })
            UIView.addKeyframe(withRelativeStartTime: 0.33, relativeDuration: 0.1, animations: {
                self.inspirativeTextLabel.alpha = 0
                self.inspirativeTextLabel.layoutIfNeeded()
                self.view.layoutIfNeeded()
            })
            
            // fait apparaitre puis disparaitre "be initiative"
            UIView.addKeyframe(withRelativeStartTime: 0.43, relativeDuration: 0.1, animations: {
                self.initiativeTextLabel.alpha = 1
                self.initiativeTextLabel.layoutIfNeeded()
                self.view.layoutIfNeeded()
            })
            UIView.addKeyframe(withRelativeStartTime: 0.56, relativeDuration: 0.1, animations: {
                self.initiativeTextLabel.alpha = 0
                self.initiativeTextLabel.layoutIfNeeded()
                self.view.layoutIfNeeded()
            })
            
            // fait apparaitre puis disparaitre "be futurist"
            UIView.addKeyframe(withRelativeStartTime: 0.66, relativeDuration: 0.1, animations: {
                self.futuristTextLabel.alpha = 1
                self.futuristTextLabel.layoutIfNeeded()
                self.view.layoutIfNeeded()
            })
            UIView.addKeyframe(withRelativeStartTime: 0.79, relativeDuration: 0.1, animations: {
                self.futuristTextLabel.alpha = 0
                self.futuristTextLabel.layoutIfNeeded()
                self.view.layoutIfNeeded()
            })
            
            // fait apparaitre le stackView et le bouton retour
            UIView.addKeyframe(withRelativeStartTime: 0.89, relativeDuration: 0.1, animations: {
                self.backButton.alpha = 1
                self.stackView.alpha = 1
                
                self.backButton.layoutIfNeeded()
                self.stackView.layoutIfNeeded()
                self.view.layoutIfNeeded()
            })
        })
    }
    
    func updateTheBackground() {
        let gradient = CAGradientLayer()
        let beginningColor = UIColor(red: 73/255, green: 89/255, blue: 120/255, alpha: 1)
        let endColor = UIColor(red: 118/255, green: 132/255, blue: 208/255, alpha: 0.8)
        gradient.colors = [beginningColor.cgColor, endColor.cgColor]
        gradient.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        globalView.layer.insertSublayer(gradient, at: 0)
    }
    
    // enleve la barre de statut en haut de l'écran
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
