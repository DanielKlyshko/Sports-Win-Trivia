
import UIKit

var userTotalScore: Int = 0

class GameView: UIViewController {
    
    var viewModel: GameViewModel!
    var selectedCategory: QuizCategory!
    
    private var currentQuestionIndex = 0
    private var selectedQuestions: [QuizQuestion] = []
    var questions: [QuizQuestion] = []
    var isRandomMode: Bool = false
    
    private let backButton = ButtonFactory.createButton(type: .backButton, title: "")
    
    private let timerLabel = UILabel()
    private var timer: Timer?
    private var timeRemaining: Int = 180
    
    private let timerCircleLayer = CAShapeLayer()
    private let timerProgressLayer = CAShapeLayer()
    
    private let questionLabel = UILabel()
    private let answersStackView = UIStackView()
    
    private var rightAnswersCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLayer = CAGradientLayer.createDarkBlueGradient()
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        view.addSubview(backButton)
        view.addSubview(timerLabel)
        view.addSubview(questionLabel)
        view.addSubview(answersStackView)
        
        setupContraints()
        setupUI()
        setupButtonActions()

        loadQuestions()
        displayCurrentQuestion()
        
        startTimer()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var shouldAutorotate: Bool {
        return false
    }

    private func setupContraints() {
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.055).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.height * 0.045).isActive = true
        
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.2).isActive = true
        
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.3).isActive = true
        questionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        questionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        answersStackView.translatesAutoresizingMaskIntoConstraints = false
        answersStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.6).isActive = true
        answersStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setupUI() {
        setupTimerCircle()
        
        timerLabel.textColor = .white
        timerLabel.font = UIFont.systemFont(ofSize: 22, weight: .heavy)
        
        questionLabel.textColor = .white
        questionLabel.font = UIFont.systemFont(ofSize: 26, weight: .heavy)
        questionLabel.numberOfLines = 0
        questionLabel.textAlignment = .center
        
        answersStackView.axis = .vertical
        answersStackView.spacing = view.frame.height * 0.02
        
        if let question = selectedCategory?.questions.first {
            questionLabel.text = question.question
            answersStackView.arrangedSubviews.forEach { $0.isHidden = true }
            for (index, option) in question.options.enumerated() {
                if index < answersStackView.arrangedSubviews.count {
                    let button = answersStackView.arrangedSubviews[index] as? UIButton
                    button?.setTitle(option, for: .normal)
                    button?.isHidden = false
                }
            }
        }
    }
    
    private func loadQuestions() {
        if isRandomMode {
            selectedQuestions = questions.shuffled().prefix(3).map { $0 }
        } else {
            selectedQuestions = selectedCategory.questions.shuffled().prefix(3).map { $0 }
        }
    }
        
    private func displayCurrentQuestion() {
        guard currentQuestionIndex < selectedQuestions.count else {
            showQuizResult()
            return
        }
            
        let question = selectedQuestions[currentQuestionIndex]
        questionLabel.text = question.question
        answersStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        question.options.forEach { option in
            let button = ButtonFactory.createButton(type: .secondaryButton(letter: ""), title: option)
            button.addTarget(self, action: #selector(answerButtonPressed(_:)), for: .touchUpInside)
            answersStackView.addArrangedSubview(button)
        }
    }
        
    private func showQuizResult() {
        timerProgressLayer.isHidden = true
        timerCircleLayer.isHidden = true
        questionLabel.isHidden = true
        timerLabel.isHidden = true
        answersStackView.isHidden = true
        
        let resultLabel = UILabel()
        resultLabel.text = "Quiz completed!"
        resultLabel.textColor = .white
        resultLabel.textAlignment = .center
        resultLabel.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        
        let rightAnswersCountLabel = UILabel()
        rightAnswersCountLabel.text = "Correct answers: \(rightAnswersCount) of \(selectedQuestions.count)"
        rightAnswersCountLabel.textColor = .white
        rightAnswersCountLabel.textAlignment = .center
        rightAnswersCountLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        
        view.addSubview(resultLabel)
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resultLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.4).isActive = true
        
        view.addSubview(rightAnswersCountLabel)
        rightAnswersCountLabel.translatesAutoresizingMaskIntoConstraints = false
        rightAnswersCountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        rightAnswersCountLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.45).isActive = true
    }

    private func setupTimerCircle() {
        let circleRadius: CGFloat = 50
        
        let circleCenter = CGPoint(x: view.frame.width / 2, y: view.frame.height * 0.215)
        
        let circularPath = UIBezierPath(arcCenter: circleCenter, radius: circleRadius, startAngle: -CGFloat.pi / 2, endAngle: 1.5 * CGFloat.pi, clockwise: true)
        
        timerCircleLayer.path = circularPath.cgPath
        timerCircleLayer.strokeColor = UIColor.black.cgColor
        timerCircleLayer.lineWidth = 10
        timerCircleLayer.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(timerCircleLayer)
        
        timerProgressLayer.path = circularPath.cgPath
        timerProgressLayer.strokeColor = UIColor.systemBlue.cgColor
        timerProgressLayer.lineWidth = 10
        timerProgressLayer.fillColor = UIColor.clear.cgColor
        timerProgressLayer.lineCap = .round
        timerProgressLayer.strokeEnd = 1.0
        view.layer.addSublayer(timerProgressLayer)
    }
    
    private func animateTimerCircle(to progress: CGFloat) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        timerProgressLayer.strokeEnd = progress
        CATransaction.commit()
    }
    
    private func startTimer() {
        timeRemaining = 30
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
        
    @objc private func updateTimer() {
        if timeRemaining > 0 {
            timeRemaining -= 1
            updateTimerLabel()
            
            let progress = CGFloat(timeRemaining) / 30
            animateTimerCircle(to: progress)
        } else {
            timer?.invalidate()
            timer = nil
            showQuizResult()
        }
    }
        
    private func updateTimerLabel() {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func setupButtonActions() {
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    @objc private func backButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func answerButtonPressed(_ sender: UIButton) {
        guard let answer = sender.titleLabel?.text else { return }
        let correctAnswer = selectedQuestions[currentQuestionIndex].correctAnswer
        
        if answer == correctAnswer {
            rightAnswersCount += 1
            userTotalScore += 1
            print("Правильный ответ!")
            changeButtonBackground(sender, isCorrect: true)
        } else {
            print("Неправильный ответ. Правильный ответ: \(correctAnswer)")
            changeButtonBackground(sender, isCorrect: false)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.currentQuestionIndex += 1
            self.displayCurrentQuestion()
        }
    }

    private func changeButtonBackground(_ button: UIButton, isCorrect: Bool) {
        UIView.animate(withDuration: 0.3) {
            button.backgroundColor = isCorrect ? UIColor.green : UIColor.red
        }
    }

}
