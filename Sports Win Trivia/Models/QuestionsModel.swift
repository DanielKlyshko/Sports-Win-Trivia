struct QuizQuestion {
    let question: String
    let options: [String]
    let correctAnswer: String
}

struct QuizCategory {
    let name: String
    let questions: [QuizQuestion]
}

let quizCategories: [QuizCategory] = [
    
    QuizCategory(name: "Light athleticism", questions: [
        QuizQuestion(question: "What distance is considered a marathon distance?", options: ["42.195 kilometres", "41.195 kilometres", "42.193 kilometres", "42.190 kilometres"], correctAnswer: "42.195 kilometres"),
        QuizQuestion(question: "In which year did Usain Bolt set the world record for 100 metres (9.58 seconds)?", options: ["2009", "2011", "2021", "1992"], correctAnswer: "2009"),
        QuizQuestion(question: "How many gold medals did the United States win in track and field at the 2021 Olympics?", options: ["8", "7", "2", "11"], correctAnswer: "8")
    ]),
    
    QuizCategory(name: "Boxing", questions: [
        QuizQuestion(question: "Who won the fight between Muhammad Ali and Joe Frazier in 1971 (first fight)?", options: ["Muhammad Ali", "Joe Frazier"], correctAnswer: "Joe Frazier"),
        QuizQuestion(question: "What title did Mike Tyson win in 1986?", options: ["Champion of the galaxy", "World heavyweight champion", "World lightweight champion", "World champion in all weights"], correctAnswer: "World heavyweight champion"),
        QuizQuestion(question: "How many rounds are common in a professional boxing fight?", options: ["12", "11", "2", "3"], correctAnswer: "12")
    ]),
    
    QuizCategory(name: "Basketball", questions: [
        QuizQuestion(question: "How many players on the court does each team have in basketball?", options: ["6", "7", "5", "11"], correctAnswer: "5"),
        QuizQuestion(question: "In what year did Michael Jordan win his first NBA championship?", options: ["1991", "1992", "1989", "2001"], correctAnswer: "1991"),
        QuizQuestion(question: "Which team won the NBA championship in 2020?", options: ["Los Angeles Lakers", "Rochester Royals", "Portland Trail Blazers", "Phoenix Suns"], correctAnswer: "Los Angeles Lakers")
    ]),
    
    QuizCategory(name: "Hockey", questions: [
        QuizQuestion(question: "How many periods are there in a hockey game?", options: ["2", "3", "1", "4"], correctAnswer: "3"),
        QuizQuestion(question: "Which country won Olympic gold in hockey in 2018?", options: ["China", "Canada", "Russia", "Japan"], correctAnswer: "Russia"),
        QuizQuestion(question: "How many players does each team have on the ice at one time (including the goalie)?", options: ["6", "11", "22", "8"], correctAnswer: "6")
    ]),
    
    QuizCategory(name: "Tennis", questions: [
        QuizQuestion(question: "Who has won the most Grand Slam tournaments among men?", options: ["Holger Rune", "Novak Djokovic", "Carlos Alcaraz", "Rafael Nadal"], correctAnswer: "Novak Djokovic"),
        QuizQuestion(question: "What surface is the Wimbledon tournament held on?", options: ["Laminate", "Rubber", "Grass", "Sand"], correctAnswer: "Grass"),
        QuizQuestion(question: "Who is the world's number one women's racket player (for 2021)?", options: ["Ashley Barty", "Iga Schwentek", "Arina Sobolenko", "Jessica Pegula"], correctAnswer: "Ashley Barty")
    ]),
    
    QuizCategory(name: "Football", questions: [
        QuizQuestion(question: "In which year was the first FIFA World Cup held?", options: ["1930", "1931", "1932", "1928"], correctAnswer: "1930"),
        QuizQuestion(question: "Which club will win the UEFA Champions League in 2020?", options: ["Bayern Munich", "Liverpool", "Manchester United", "Barcelona"], correctAnswer: "Bayern Munich"),
        QuizQuestion(question: "Who is the top scorer in World Cup history?", options: ["Miroslav Klose", "Cristiano Ronaldo ", "Lionel Messi", "Gian Luigi Buffon"], correctAnswer: "Miroslav Klose")
    ])
    
]
