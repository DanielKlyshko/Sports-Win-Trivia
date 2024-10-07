import UIKit

class StartView: UIViewController {

    private let viewModel = StartViewModel()
    
    private let logoImageView = UIImageView()
    private let startButton = UIButton(type: .system)
    private let menuButtonsStackView = UIStackView(arrangedSubviews: [
        ButtonFactory.createButton(type: .primaryButton, title: "Category"),
        ButtonFactory.createButton(type: .primaryButton, title: "Settings"),
        ButtonFactory.createButton(type: .primaryButton, title: "Leaderboard")
    ])
    
    var allQuestions: [QuizQuestion] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLayer = CAGradientLayer.createDarkBlueGradient()
            gradientLayer.frame = view.bounds
            view.layer.insertSublayer(gradientLayer, at: 0)
        
        view.addSubview(logoImageView)
        view.addSubview(startButton)
        view.addSubview(menuButtonsStackView)
        
        setupContraints()
        setupUI()
        setupButtonActions()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var shouldAutorotate: Bool {
        return false
    }

    private func setupContraints() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.55).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.1).isActive = true
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.42).isActive = true
        startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        menuButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        menuButtonsStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.65).isActive = true
        menuButtonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setupUI() {
        logoImageView.image = UIImage(named: "AppLogo")
        
        startButton.setTitle("START GAME", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.setTitleColor(.systemGray2, for: .highlighted)
        startButton.titleLabel?.font = .systemFont(ofSize: 40, weight: .heavy)
        startButton.backgroundColor = .systemBlue
        startButton.layer.cornerRadius = 30
        
        menuButtonsStackView.axis = .vertical
        menuButtonsStackView.alignment = .center
        menuButtonsStackView.spacing = 20
    }
    
    private func setupButtonActions() {
        
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        
        if let categoryButton = menuButtonsStackView.arrangedSubviews[0] as? UIButton {
            categoryButton.addTarget(self, action: #selector(openCategoryView), for: .touchUpInside)
        }
        if let settingsButton = menuButtonsStackView.arrangedSubviews[1] as? UIButton {
            settingsButton.addTarget(self, action: #selector(openSettingsView), for: .touchUpInside)
        }
        if let leaderboardButton = menuButtonsStackView.arrangedSubviews[2] as? UIButton {
            leaderboardButton.addTarget(self, action: #selector(openLeaderboardView), for: .touchUpInside)
        }
    }

    private func getRandomQuestions(from categories: [QuizCategory], count: Int) -> [QuizQuestion] {
        var allQuestions: [QuizQuestion] = []

        for category in categories {
            allQuestions.append(contentsOf: category.questions)
        }

        allQuestions.shuffle()
        
        return Array(allQuestions.prefix(count))
    }

    @objc private func startButtonPressed() {
        let gameView = GameView()
        let randomQuestions = getRandomQuestions(from: quizCategories, count: 3)
        gameView.questions = randomQuestions
        gameView.isRandomMode = true
        gameView.modalPresentationStyle = .fullScreen
        present(gameView, animated: true, completion: nil)
        SoundManager.shared.playClickSound()
    }
    
    @objc private func openCategoryView() {
        let categoryVC = CategoryView()
        categoryVC.modalPresentationStyle = .fullScreen
        present(categoryVC, animated: true, completion: nil)
    }
    
    @objc private func openSettingsView() {
        let settingsVC = SettingsView()
        settingsVC.modalPresentationStyle = .fullScreen
        present(settingsVC, animated: true, completion: nil)
    }
    
    @objc private func openLeaderboardView() {
        let leaderboardVC = LeaderboardView()
        leaderboardVC.modalPresentationStyle = .fullScreen
        present(leaderboardVC, animated: true, completion: nil)
    }
}
