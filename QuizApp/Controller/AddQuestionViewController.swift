import UIKit
import DropDownMenuKit
import FirebaseCore
import FirebaseFirestore
import Firebase

class AddQuestionViewController: ViewController {
    
    @IBOutlet weak var questionLabel: UITextField!
    @IBOutlet weak var optionOne: UITextField!
    @IBOutlet weak var optionTwo: UITextField!
    @IBOutlet weak var optionThree: UITextField!
    @IBOutlet weak var optionFour: UITextField!
    
    @IBOutlet weak var selectCategoryBtn: UIButton!
    @IBOutlet var categoryCollection: [UIButton]!
    var subjectId : String!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database(url: C.RealtimeDatabase.url).reference()
        
        categoryCollection.forEach{btn in
            btn .isHidden = true
            btn.alpha = 0
        }
    }
    
    func writeQuestion() -> Question{
        let title = questionLabel.text ?? "nil"
        let optionOne = optionOne.text ?? "nil"
        let optionTwo = optionTwo.text ?? "nil"
        let optionThree = optionThree.text ?? "nil"
        let optionFour = optionFour.text ?? "nil"
        let question = Question(title: title, subject: subjectId, options: [optionOne : true,optionTwo : false,optionThree : false,optionFour : false])
        return question
    }
    
    @IBAction func pressedSave(_ sender: UIButton) {
        let writeQuestion = writeQuestion()
        addQuestion(question: writeQuestion)
        
        let alert = UIAlertController(title: "Saved", message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                self.performSegue(withIdentifier: C.addToCategory, sender: self)
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }
        }))
    }
    
    
    @IBAction func pressedCancel(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Are you sure?", message: "Your question will be permanently deleted.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                self.performSegue(withIdentifier: C.addToCategory, sender: self)
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
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
    }
    
    func addQuestion(question : Question){
        self.ref.child("questions").childByAutoId().setValue(["title" : question.title, "subject" : question.subject, "options" : question.options])

    }
    
    @IBAction func selectCategoryPressed(_ sender: UIButton) {
        categoryCollection.forEach{btn in
            UIView.animate(withDuration: 0.7){
                btn.isHidden = !btn.isHidden
                btn.alpha = btn.alpha == 0 ? 1 : 0
                btn.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func categoryPressed(_ sender: UIButton) {
        if let btnLabel = sender.titleLabel?.text{
            if btnLabel == "History"{
                subjectId = "d11"
            }else if btnLabel == "Turk History"{
                
            }else if btnLabel == "Geography"{
                
            }else if btnLabel == "Capital Cities"{
                
            }else if btnLabel == "Science and Technology"{
                
            }else if btnLabel == "General Knowledge"{
                
            }else if btnLabel == "Sports"{
                
            }else if btnLabel == "Movies"{
                
            }else{
                    print("Error")
            }
        }
    }
    
}
