import UIKit

class ScoreViewController: UIViewController {
    
    @IBOutlet weak var congratsImg: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var score : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        scoreLabel.text = "Score : \(score ?? 0)"
    }
    
    @IBAction func pressedFinish(_ sender: Any) {
        self.performSegue(withIdentifier: C.scoreToCategory, sender: self)
    }
}
