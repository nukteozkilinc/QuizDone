struct C{
    static let registerSegue = "RegisterToCategory"
    static let loginSegue = "LoginToCategory"
    static let categorySegue = "CategoryToQuiz"
    static let addSegue = "CategoryToAdd"
    static let scoreToCategory = "ScoreToCategory"
    
    struct FireStore {
        static let quizTitle = "quizTitle"
        static let quizId = "quizId"
        static let quizDesc = "quizDesc"
        static let quizImg = "quizImgUrl"
    }
    
    struct RealtimeDatabase {
        static let url = "https://quizdone-e2e34-default-rtdb.firebaseio.com/"
        
    }
}
