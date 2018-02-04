import UIKit

class QuizzViewController: UIViewController {

    // MARK : outlets
    @IBOutlet var globalView: UIView!
    
    // MARK : variables
    let gradient = CAGradientLayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Arranging the background (creating a gradient of color for the view)
        var expension = CGAffineTransform()
        expension.a = 3
        expension.d = 2
        expension.tx = -100
        expension.ty = -300
        print(expension)
        gradient.frame = globalView.frame.applying(expension)
        print(gradient.frame)
        gradient.colors = [ UIColor.orange.cgColor, UIColor.clear.cgColor]
        gradient.transform = CATransform3DMakeRotation(0*CGFloat.pi / 6, 0, 0, 1)
        
        globalView.layer.insertSublayer(gradient, at: 0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
