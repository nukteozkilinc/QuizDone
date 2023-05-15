import UIKit
import FirebaseAuth

class CategoryViewController : UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        title = "QuizDone"
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
          try Auth.auth().signOut()
            navigationController?.popViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}
