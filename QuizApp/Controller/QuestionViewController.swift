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
    @IBOutlet weak var scoreLabel: UILabel!
    
    let db = Firestore.firestore()
    var categoryIndex : String?
    var ref: DatabaseReference!
    var questionsArray : [Question] = []
    var questionCount : Int = 0
    var score : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database(url: C.RealtimeDatabase.url).reference()
       
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
    
    func takingAnswerTitles() -> [String]{
        var answerTitles : [String] = []
        for answers in questionsArray[questionCount].options.keys{
            answerTitles.append(answers)
        }
        return answerTitles
    }
    
    func answerChecked() -> [Bool]{
        var checkedar : [Bool] = []
        let answerTitles = takingAnswerTitles()
        for index in answerTitles{
            if let checked = questionsArray[questionCount].options[index]{
                checkedar.append(checked)
            }
        }
        return checkedar
    }
        
    @IBAction func pressAnswer(_ sender: UIButton) {
        
        let check = answerChecked()
        let myAnswer = Int(sender.restorationIdentifier ?? "") ?? 0
        
        if check[myAnswer] == true{
            score = score + 1
            sender.backgroundColor = UIColor.green
        }else{
            sender.backgroundColor = UIColor.red
        }
        
            if questionCount != questionsArray.count - 1 {
                questionCount = questionCount + 1
            }else{
                self.performSegue(withIdentifier: C.quizToScore, sender: self)
            }
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        }
    
    @objc func updateUI(){
        let answerTitles = takingAnswerTitles()
        questionLabel.text = questionsArray[questionCount].title
        firstButton.setTitle(answerTitles[0], for: .normal)
        secondButton.setTitle(answerTitles[1], for: .normal)
        thirdButton.setTitle(answerTitles[2], for: .normal)
        fourthButton.setTitle(answerTitles[3], for: .normal)
        firstButton.backgroundColor = UIColor.clear
        secondButton.backgroundColor = UIColor.clear
        thirdButton.backgroundColor = UIColor.clear
        fourthButton.backgroundColor = UIColor.clear
        scoreLabel.text = "Score : \(score)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ScoreViewController
        destinationVC.score = score
    }
}


