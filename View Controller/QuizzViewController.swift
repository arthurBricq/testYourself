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
        expension.tx = -self.view.bounds.height
        expension.ty = -self.view.bounds.height
        print(expension)
        //gradient.frame = globalView.frame.applying(expension)
        
        print(gradient.frame)
        let beginningColor = UIColor(red: 248/255, green: 198/255, blue: 123/255, alpha: 1)
        let endColor = UIColor(red: 248/255, green: 198/255, blue: 123/255, alpha: 0.6)
        gradient.colors = [beginningColor.cgColor , endColor.cgColor]
        gradient.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        gradient.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        globalView.layer.insertSublayer(gradient, at: 0)
        
        // Changing the color of the text in the segmented control.
        let myFont = UIFont(name: "Avenir", size: 16)
        let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.darkGray, NSAttributedStringKey.font: myFont]
        segmentedControl.setTitleTextAttributes(textAttributes, for: .normal)
        segmentedControl.setTitleTextAttributes(textAttributes, for: .selected)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // This function is called when the buton return on the keyboard is tapped. The view controller class must be part of UITextFieldDelegate.
        self.view.endEditing(true)
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
