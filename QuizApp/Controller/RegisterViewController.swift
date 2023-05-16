import UIKit
//import FirebaseCore
import FirebaseAuth

class RegisterViewController : UIViewController{
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text , let password = passwordTextField.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription) // You can add pop up alert
                }else{
                    //Navigate to Category
                    self.performSegue(withIdentifier: C.registerSegue, sender: self)
                }
            }
        }
    }
}
