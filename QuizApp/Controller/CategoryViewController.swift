import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class CategoryViewController : UIViewController{
    
    //@IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var desc1: UILabel!
    @IBOutlet weak var title2: UILabel!
    @IBOutlet weak var desc2: UILabel!
    @IBOutlet weak var title3: UILabel!
    @IBOutlet weak var desc3: UILabel!
    @IBOutlet weak var title4: UILabel!
    @IBOutlet weak var desc4: UILabel!
    @IBOutlet weak var title5: UILabel!
    @IBOutlet weak var desc5: UILabel!
    @IBOutlet weak var title6: UILabel!
    @IBOutlet weak var desc6: UILabel!
    @IBOutlet weak var title7: UILabel!
    @IBOutlet weak var desc7: UILabel!
    @IBOutlet weak var title8: UILabel!
    @IBOutlet weak var desc8: UILabel!
    
    //func FirebaseApp;.configure()
    let db = Firestore.firestore()
    
    var categories : [Category] = []
    var questionIndex : String?
    override func viewDidLoad() {
        super.viewDidLoad()
    
        title = "QuizDone"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToAdd))
        navigationItem.hidesBackButton = true
        
        loadCategories()
    }
    
    func loadCategories(){ // Recieving categories from database
        
        db.collection("Quiz").getDocuments() { (querySnapshot, err) in
            
            if let err = err {
                print("There was an error retrieving from Firestore \(err)")
            } else {
                if let snaphotDocuments = querySnapshot?.documents{
                    for doc in snaphotDocuments{
                        let data = doc.data()
                        if let quizTitle = data[C.FireStore.quizTitle] as? String ,
                        let quizDesc = data[C.FireStore.quizDesc] as? String ,
                        let quizImg = data[C.FireStore.quizImg] as? String ,
                        let quizId = data[C.FireStore.quizId] as? String {
                            let category = Category(
                                quizDesc: quizDesc,
                                quizId: quizId,
                                quizImgUrl: quizImg,
                                quizTitle: quizTitle
                            )
                            self.categories.append(category)
                            
                            DispatchQueue.main.async {
                                self.edit(category: self.categories[0], title: self.title1, desc : self.desc1)
                                self.edit(category: self.categories[1], title: self.title2, desc : self.desc2)
                                self.edit(category: self.categories[2], title: self.title3, desc : self.desc3)
                                self.edit(category: self.categories[3], title: self.title4, desc : self.desc4)
                                self.edit(category: self.categories[4], title: self.title5, desc : self.desc5)
                                self.edit(category: self.categories[5], title: self.title6, desc : self.desc6)
                                self.edit(category: self.categories[6], title: self.title7, desc : self.desc7)
                                self.edit(category: self.categories[7], title: self.title8, desc : self.desc8)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
          try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
            dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func edit(category : Category, title : UILabel, desc : UILabel){
        title.text = category.quizTitle
        desc.text = category.quizDesc
    }
    
    @IBAction func goToQuiz(_ sender: UIButton) {
        
        let senderId = sender.restorationIdentifier ?? "0"
        let index : Int = Int(senderId) ?? 0
        questionIndex = categories[index].quizId
      
        self.performSegue(withIdentifier: C.categorySegue, sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == C.categorySegue{
            let destinationVC = segue.destination as! QuestionViewController
            destinationVC.categoryIndex = questionIndex
        }
    }
    
    @objc func goToAdd(){
        self.performSegue(withIdentifier: C.addSegue, sender: self)
    }
}



