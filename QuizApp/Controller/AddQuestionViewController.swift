import UIKit
import FirebaseCore
import FirebaseFirestore
import Firebase

class AddQuestionViewController: ViewController {
    
    
    @IBOutlet weak var questionLabel: UITextView!
    @IBOutlet weak var optionOne: UITextView!
    @IBOutlet weak var optionFour: UITextView!
    @IBOutlet weak var optionTwo: UITextView!
    @IBOutlet weak var selectCategoryBtn: UIButton!
    @IBOutlet var categoryCollection: [UIButton]!
    @IBOutlet weak var optionThree: UITextView!
    
    
    var ref: DatabaseReference!
    let db = Firestore.firestore()
    var subjectId : String!
    
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
    
        let alert = UIAlertController(title: "Your question has been saved", message: "We have forwarded your question to our team for review.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                self.performSegue(withIdentifier: C.addToCategory, sender: self)
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            @unknown default:
                print("error")
            }
        }))
        self.present(alert, animated: true, completion: nil)
        
        let writeQuestion = writeQuestion()
        addQuestion(question: writeQuestion)
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
            @unknown default:
                print("error")
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
            @unknown default:
                print("error")
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func addQuestion(question : Question){
        // Add a new document with a generated id.
        var ref: DocumentReference? = nil
        ref = db.collection("QuizSuggestions").addDocument(data: [
            "quizSubject": question.title,
            "quizId": question.subject,
            "quizOptions" : question.options
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
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
            subjectId = btnLabel
            selectCategoryBtn.titleLabel?.text = btnLabel
            categoryCollection.forEach{btn in
                btn .isHidden = true
                btn.alpha = 0
            }
        }
    }
}
