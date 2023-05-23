import UIKit
import FirebaseCore
import FirebaseFirestore
import Firebase


class QuestionViewController : UIViewController{
    
    @IBOutlet weak var questionLabel: UILabel!
    
    let db = Firestore.firestore()
    var categoryIndex : String?
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database(url: "https://quizdone-e2e34-default-rtdb.firebaseio.com/").reference()
        
        questionLabel.text = categoryIndex
        getData()        
    }
    
    func getData(){
        /*ref.child("questions").child(categoryIndex ?? "g5").observeSingleEvent(of: .value, with: { snapshot in
          // Get user value
          let value = snapshot.value as? NSDictionary
          let subject = value?["subject"] as? String ?? ""
          let title = value?["title"] as? String ?? ""
          let options = value?["options"] as? [String : Bool]
          let question = Question(title: title, subject: subject, options: options!)
            print(self.categoryIndex ?? "Gelmedi")
            print(question.subject)
            print(question.title)
            print(question.options)
          // ...
        }) { error in
          print(error.localizedDescription)
        }*/
        ref.child("questions").observeSingleEvent(of: .value, with: { snapshot in
          // Get user value
          let value = snapshot.value as? NSDictionary
          let subject = value?["subject"] as? String ?? ""
          let title = value?["title"] as? String ?? ""
          let options = value?["options"] as? [String : Bool]
          let question = Question(title: title, subject: subject, options: options!)
            print(self.categoryIndex ?? "Gelmedi")
            print(question.subject)
            print(question.title)
            print(question.options)
          // ...
        }) { error in
          print(error.localizedDescription)
        }
    }
}
