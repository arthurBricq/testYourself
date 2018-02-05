import UIKit

class QuizzViewController: UIViewController, UITextFieldDelegate {

    // MARK : outlets
    @IBOutlet var globalView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!
    
    
    // MARK : variables
    let gradient = CAGradientLayer()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Arranging the background (creating a gradient of color for the view)
        var expension = CGAffineTransform()
        expension.a = 1
        expension.d = 2
        expension.tx = 0
        expension.ty = -300
        print(expension)
        gradient.frame = globalView.frame.applying(expension)
        print(gradient.frame)
        //let myColor = UIColor(displayP3Red: 255, green: 168, blue: 52, alpha: 0.65)
        let myColor = UIColor(red: 255/255, green: 168/255, blue: 52/255, alpha: 0.7)
        gradient.colors = [ myColor.cgColor , UIColor.clear.cgColor]
        gradient.transform = CATransform3DMakeRotation(0*CGFloat.pi / 12, 0, 0, 1)
        globalView.layer.insertSublayer(gradient, at: 0)
        
        // Changing the color of the text in the segmented control.
        let myFont = UIFont(name: "Avenir", size: 16)
        let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.darkGray, NSAttributedStringKey.font: myFont]
        segmentedControl.setTitleTextAttributes(textAttributes, for: .normal)
        segmentedControl.setTitleTextAttributes(textAttributes, for: .selected)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // This function is called when the buton return is tapped. The view controller class must be part of UITextFieldDelegate. 
        self.view.endEditing(true)
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
