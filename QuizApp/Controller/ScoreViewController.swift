import UIKit

class ScoreViewController: UIViewController {
    
    @IBOutlet weak var congratsImg: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    
    var score : Int?
    var count : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        scoreLabel.text = "Score : \(score ?? 0)"
        print(count!)
        print(score!)
        if score! > count!/2{
            congratsImg.image = UIImage(imageLiteralResourceName: "full")
            adviceLabel.text = "Well Done!"
        }else if score! == count!/2{
            congratsImg.image = UIImage(imageLiteralResourceName: "yarisi")
            adviceLabel.text = "You are between the knowledgeable and the ignorant."
        }else{
            congratsImg.image = UIImage(imageLiteralResourceName: "berbat")
            adviceLabel.text = "I'm sure there are things you're good at, too."
        }
    }
    
    @IBAction func pressedFinish(_ sender: Any) {
        self.performSegue(withIdentifier: C.scoreToCategory, sender: self)
    }
}
