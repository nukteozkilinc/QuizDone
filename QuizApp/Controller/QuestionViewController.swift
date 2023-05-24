import UIKit
import FirebaseCore
import FirebaseFirestore
import Firebase


class QuestionViewController : UIViewController{
    
    @IBOutlet weak var questionLabel: UILabel!
    
    let db = Firestore.firestore()
    var categoryIndex : String?
    var ref: DatabaseReference!
    var questionsArray : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database(url: "https://quizdone-e2e34-default-rtdb.firebaseio.com/").reference()
        
        questionLabel.text = categoryIndex
        getData()
    }
    
    func getData(){
        questionsArray = []
        ref.child("questions").observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let placeDict = snap.value as! [String: Any]
                let subject = placeDict["subject"] as! String
                let title = placeDict["title"] as! String
                if subject == self.categoryIndex{
                    self.questionsArray.append(title)
                }
            }
        }) { error in
          print(error.localizedDescription)
        }
    }
}
