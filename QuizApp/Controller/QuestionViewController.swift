import UIKit
import FirebaseCore
import FirebaseFirestore

class QuestionViewController : UIViewController{
    
    @IBOutlet weak var questionLabel: UILabel!
    
    let db = Firestore.firestore()
    var categoryIndex : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionLabel.text = categoryIndex
        
        
    }
}
