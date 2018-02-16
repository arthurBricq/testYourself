import UIKit

class QuizzViewController: UIViewController, UITextFieldDelegate {

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK : outlets
    @IBOutlet var globalView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var textFieldWidth: NSLayoutConstraint!
    @IBOutlet weak var genderView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    // MARK : variables
    let gradient = CAGradientLayer()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Arranging the background (creating a gradient of color for the view)
        // set the colors
        let beginningColor = UIColor(red: 248/255, green: 198/255, blue: 123/255, alpha: 1)
        let endColor = UIColor(red: 248/255, green: 198/255, blue: 123/255, alpha: 0.6)
        gradient.colors = [beginningColor.cgColor, endColor.cgColor]
        // tourne le gradiant d'un quart vers la gauche
        gradient.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        // met le gradiant de la taille de l'écran
        gradient.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        globalView.layer.insertSublayer(gradient, at: 0)
        
        // Changing the color of the text in the segmented control.
        let myFont = UIFont(name: "Avenir", size: 20)
        let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.darkGray, NSAttributedStringKey.font: myFont]
        segmentedControl.setTitleTextAttributes(textAttributes, for: .normal)
        segmentedControl.setTitleTextAttributes(textAttributes, for: .selected)
        
        // enleve le correcteur d'orthographe
        textField.autocorrectionType = .no
        
        // Arranging the first Stack
        let globalWidth = self.view.frame.width
        textField.center.x = self.view.center.x
        nameView.center.x = self.view.center.x
        let nameViewWidthConstraint = NSLayoutConstraint(item: nameView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: globalWidth)
        nameViewWidthConstraint.isActive = true
        textFieldWidth.constant = 0.6*globalWidth
        
        // Arranging the second stackView
        genderView.center.x = self.view.center.x
        segmentedControl.center.x = self.view.center.x
        let genderViewWidthConstraint = NSLayoutConstraint(item: genderView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: globalWidth)
        genderViewWidthConstraint.isActive = true
        
        // Tap gesture recognizer on the view
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapOnTheScreen(recognizer:)))
        self.view.addGestureRecognizer(tapRecognizer)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // This function is called when the buton return on the keyboard is tapped. The view controller class must be part of UITextFieldDelegate.
        self.view.endEditing(true)
        return true
    }
    // fait degager le clavier quand on appuie à l'écran
    @objc func tapOnTheScreen(recognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func pressAGoButton(_ sender: customButton) {
        if textField.text != "" {
            if sender.id == 0 {
                activeQuizz = firstQuizz
            } else if sender.id == 1 {
                activeQuizz = firstQuizz
            } else if sender.id == 2 {
                activeQuizz = firstQuizz
            }
            
            // il faut sauvegarder les infos ici :
            name = textField.text!
            if segmentedControl.selectedSegmentIndex == 0 {
                isAMale = false
            } else {
                isAMale = true
            }
            
            performSegue(withIdentifier: "ToGameViewController", sender: self)
        } else {
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.07
            animation.repeatCount = 3
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: textField.center.x - 7, y: textField.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: textField.center.x + 7, y: textField.center.y))
            
            textField.layer.add(animation, forKey: "position")
        }
    }
}
