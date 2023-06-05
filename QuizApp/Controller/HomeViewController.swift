import UIKit
import FirebaseAuth

class HomeViewController: ViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        authenticateUserAndConfigureView()
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        authenticateUserAndConfigureView()
    }
    
    func authenticateUserAndConfigureView(){
        if Auth.auth().currentUser == nil{
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: C.goToFirstScreen, sender: self)
                self.dismiss(animated: true)
            }
        }else{
            self.performSegue(withIdentifier: C.goToCategory, sender: self)
            self.dismiss(animated: true)
        }
    }
}
