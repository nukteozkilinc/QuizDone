import UIKit
import FirebaseAuth
import GoogleSignIn
import FirebaseCore


class LoginViewController : UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text , let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if error != nil {
                    let alert = UIAlertController(title: "Incorrect Email or Password", message: "Please check your details and try again.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        switch action.style{
                        case .default:
                            print("default")
                        case .cancel:
                            print("cancel")
                        case .destructive:
                            print("destructive")
                        @unknown default:
                            print("error")
                        }
                    }))
                    self.present(alert, animated: true, completion: nil)
                }else{
                    //Navigate to Category
                    self.performSegue(withIdentifier: C.loginSegue, sender: self)
                }
            }
        }
    }
    
    
    @IBAction func googleAuthPressed(_ sender: UIButton) {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { result, error in
            if let e = error{
                print(e)
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Login Successful.")
                    self.performSegue(withIdentifier: C.loginSegue, sender: self)
                }
            }
        }
    }
    
    
    @IBAction func forgotPassword(_ sender: UIButton) {
        if let email = emailTextField.text{
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if error != nil{
                    let alert = UIAlertController(title: "Sorry, something went wrong.", message: "Please check your email address.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        switch action.style{
                        case .default:
                            print("default")
                        case .cancel:
                            print("cancel")
                        case .destructive:
                            print("destructive")
                        @unknown default:
                            print("error")
                        }
                    }))
                    self.present(alert, animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title: "Password Reset Email Sent!", message: "An email has been sent to your email address.Follow the directions to reset your password.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        switch action.style{
                        case .default:
                            print("default")
                        case .cancel:
                            print("cancel")
                        case .destructive:
                            print("destructive")
                        @unknown default:
                            print("error")
                        }
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}
