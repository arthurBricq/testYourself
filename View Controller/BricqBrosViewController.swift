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
        print("just a little test")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //firstAnimation()
        animateTheView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepareForAnimation() {
        stackView.isHidden = true
        backButton.isHidden = false
        //initiativeTextLabel.isHidden = true
        initiativeTextLabel.alpha = 0
        //inspirativeTextLabel.isHidden = true
        inspirativeTextLabel.alpha = 0
        //futuristTextLabel.isHidden = true
        futuristTextLabel.alpha = 0
        bricqConstraint.constant = -100
        brosConstraint.constant = -100
        self.view.layoutIfNeeded()
    }
    
    func animateTheView() {
        prepareForAnimation()
        
        UIView.animateKeyframes(withDuration: 7, delay: 0, options: .calculationModeLinear, animations: {
            self.brosConstraint.constant = 180
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            })
            
            self.bricqConstraint.constant = 100
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            })
            
            
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.10, animations: {
                self.inspirativeTextLabel.alpha = 1
                self.inspirativeTextLabel.layoutIfNeeded()
                self.view.layoutIfNeeded()
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.10, animations: {
                self.inspirativeTextLabel.alpha = 0
                self.inspirativeTextLabel.layoutIfNeeded()
                self.view.layoutIfNeeded()
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.10, animations: {
                self.initiativeTextLabel.alpha = 1
                self.initiativeTextLabel.layoutIfNeeded()
                self.view.layoutIfNeeded()
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.10, animations: {
                self.initiativeTextLabel.alpha = 0
                self.initiativeTextLabel.layoutIfNeeded()
                self.view.layoutIfNeeded()
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.10, animations: {
                self.futuristTextLabel.alpha = 1
                self.futuristTextLabel.layoutIfNeeded()
                self.view.layoutIfNeeded()
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.9, relativeDuration: 0.10, animations: {
                self.futuristTextLabel.alpha = 0
                self.futuristTextLabel.layoutIfNeeded()
                self.view.layoutIfNeeded()
            })
            
        }) { (finished) in
            if !finished {
                return
            }
            
        }
    }
    
    func firstAnimation()
    {
        prepareForAnimation()
        
        brosConstraint.constant = 180
        UIView.animate(withDuration: 0.8, delay: 0.1, options: .curveEaseInOut , animations: {
            self.view.layoutIfNeeded()
        }) { (tmp1) in
            self.bricqConstraint.constant = 100
            UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
                self.view.layoutIfNeeded()
            }) { (tmp1) in
                if (!tmp1) {
                    return
                }
                //self.secondAnimation()
            }
        }
    }
    
    
    
    /*func secondAnimation() {
        self.textLabel.isHidden = false
        
        // FIRST TEXT
        self.textLabel.text = "Be Innovative"
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
            self.textLabel.alpha = 1
            self.textLabel.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }) { (tmp1) in
            UIView.animate(withDuration: 1.0, delay: 0.8, options: .curveEaseInOut, animations: {
                self.textLabel.alpha = 0
                self.textLabel.layoutIfNeeded()
                self.view.layoutIfNeeded()

            }, completion: { (tmp2) in
                
                
                // SECOND TEXT
                self.textLabel.text = "Be Inspirative"
                UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
                    self.textLabel.alpha = 1
                    self.textLabel.layoutIfNeeded()
                    self.view.layoutIfNeeded()

                }, completion: { (tmp3) in
                    UIView.animate(withDuration: 1.0, delay: 0.8, options: .curveEaseInOut, animations: {
                        self.textLabel.alpha = 0
                        self.textLabel.layoutIfNeeded()
                        self.view.layoutIfNeeded()

                    }, completion: { (tmp4) in
                        
                        
                        // THIRD TEXT
                        self.textLabel.text = "Be Futurist"
                        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
                            self.textLabel.alpha = 1
                            self.textLabel.layoutIfNeeded()
                            self.view.layoutIfNeeded()

                        }, completion: { (tmp5) in
                            UIView.animate(withDuration: 1.0, delay: 0.8, options: .curveEaseInOut, animations: {
                                self.textLabel.alpha = 0
                                self.textLabel.layoutIfNeeded()
                                self.view.layoutIfNeeded()

                            }, completion: { (tmp6) in
                                // FINISHED !!!!!!
                            })
                        })
                        
                    })
                })
            })
        }
    }
    */
    
    func thirdAnimation() {
        
    }
    
    
    func wait(time: CGFloat) {
        
    }
    
    func updateTheBackground() {
        let gradient = CAGradientLayer()
        let beginningColor = UIColor(red: 73/255, green: 89/255, blue: 120/255, alpha: 1)
        let endColor = UIColor(red: 118/255, green: 132/255, blue: 208/255, alpha: 0.8)
        gradient.colors = [beginningColor.cgColor, endColor.cgColor]
        //gradient.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        gradient.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        globalView.layer.insertSublayer(gradient, at: 0)
    }
    

}
