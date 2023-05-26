import UIKit

class ScoreViewController: UIViewController {
    
    @IBOutlet weak var congratsImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func pressedFinish(_ sender: Any) {
        self.performSegue(withIdentifier: "ScoreToCategory", sender: self)
    }
}
