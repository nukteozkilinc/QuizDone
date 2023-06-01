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
                    print(e.localizedDescription)
                    let alert = UIAlertController(title: "Sorry, something went wrong", message: " Please try again later.", preferredStyle: UIAlertController.Style.alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        switch action.style{
                        case .default:
                            print("default")
                            
                        case .cancel:
                            print("cancel")
                            
                        case .destructive:
                            print("destructive")
                        }
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                }else{
                    //Navigate to Category
                    self.performSegue(withIdentifier: C.registerSegue, sender: self)
                }
            }
        }
    }
}
