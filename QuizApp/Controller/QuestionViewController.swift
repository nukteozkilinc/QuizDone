import UIKit
import FirebaseCore
import FirebaseFirestore
import Firebase


class QuestionViewController : UIViewController{
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!
    
    let db = Firestore.firestore()
    var categoryIndex : String?
    var ref: DatabaseReference!
    var questionsArray : [Question] = []
    var questionCount : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database(url: "https://quizdone-e2e34-default-rtdb.firebaseio.com/").reference()
        
        //questionLabel.text = categoryIndex
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
                let options = placeDict["options"] as! Dictionary<String , Bool>
                if subject == self.categoryIndex{
                    let question = Question(title: title, subject: subject, options: options)
                    self.questionsArray.append(question)
                }
            }
            self.updateUI()
        }) { error in
            print(error.localizedDescription)
        }
    }
    
    func updateUI(){
        var answerTitles = takingAnswerTitles()
        questionLabel.text = questionsArray[questionCount].title
        firstButton.setTitle(answerTitles[0], for: .normal)
        secondButton.setTitle(answerTitles[1], for: .normal)
        thirdButton.setTitle(answerTitles[2], for: .normal)
        fourthButton.setTitle(answerTitles[3], for: .normal)
    }
    
    func takingAnswerTitles() -> [String]{
        var answerTitles : [String] = []
        for answers in questionsArray[questionCount].options.keys{
            answerTitles.append(answers)
        }
        return answerTitles
    }
    
    func answerChecked() -> [Bool]{
        var checkedar : [Bool] = []
        var answerTitles = takingAnswerTitles()
        for index in answerTitles{
            if let checked = questionsArray[questionCount].options[index]{
                checkedar.append(checked)
                /*if checked == true{
                    //print("true")
                    
                }else{
                    //("false")
                    //sender.backgroundColor = UIColor.red
                }*/
            }
            //firstButton.setTitle(questionsArray[questionCount].title, for: .normal)
            //for (answer , checked) in questionsArray[questionCount].options{
            //       print("answer \(answer) , checked \(checked)")
            //}
        }
        return checkedar
    }
        
    @IBAction func pressAnswer(_ sender: UIButton) {
        
        let check = answerChecked()
        let myAnswer = Int(sender.restorationIdentifier ?? "") ?? 0
        
        if check[myAnswer] == true{
                print("true")
            sender.backgroundColor = UIColor.green
        }else{
            print("false")
            sender.backgroundColor = UIColor.red
        }
        
            if questionCount != questionsArray.count - 1 {
                questionCount = questionCount + 1
                updateUI()
                
                
            }else{
                print("Bitti")
            }
        }
    }


