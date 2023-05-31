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
        var title = questionLabel.text ?? "nil"
        var optionOne = optionOne.text ?? "nil"
        var optionTwo = optionTwo.text ?? "nil"
        var optionThree = optionThree.text ?? "nil"
        var optionFour = optionFour.text ?? "nil"
        var question = Question(title: title, subject: subjectId, options: [optionOne : true,optionTwo : false,optionThree : false,optionFour : false])
        return question
    }
    
    @IBAction func pressedSave(_ sender: UIButton) {
       // addQuestion()
        let writeQuestion = writeQuestion()
        addQuestion(question: writeQuestion)
    }
    
    
    @IBAction func pressedCancel(_ sender: UIButton) {
    }
    
    func addQuestion(question : Question){
        print("Burda")
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
            }
            
        }
    }
    
}
