
import UIKit

class CategoryView: UIViewController {
    
    var viewModel: CategoryViewModel!
    
    private let backButton = ButtonFactory.createButton(type: .backButton, title: "")
    private let pageHeaderLabel = UILabel()
    private let categoorieCardsFirstColumnStackView = UIStackView(arrangedSubviews: [
        ButtonFactory.createButton(type: .categoryButton(text: "Light athleticism", icon: UIImage(named: "lightAthletismIcon")), title: ""),
        ButtonFactory.createButton(type: .categoryButton(text: "Basketball", icon: UIImage(named: "basketballIcon")), title: ""),
        ButtonFactory.createButton(type: .categoryButton(text: "Tennis", icon: UIImage(named: "tennisIcon")), title: "")
    ])
    
    private let categoorieCardsSecondtColumnStackView = UIStackView(arrangedSubviews: [
        ButtonFactory.createButton(type: .categoryButton(text: "Boxing", icon: UIImage(named: "boxingIcon")), title: ""),
        ButtonFactory.createButton(type: .categoryButton(text: "Hockey", icon: UIImage(named: "hockeyIcon")), title: ""),
        ButtonFactory.createButton(type: .categoryButton(text: "Football", icon: UIImage(named: "footballIcon")), title: "")
    ])
    
    private let categoorieCardsMainStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLayer = CAGradientLayer.createDarkBlueGradient()
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        view.addSubview(backButton)
        view.addSubview(pageHeaderLabel)
        categoorieCardsMainStackView.addArrangedSubview(categoorieCardsFirstColumnStackView)
        categoorieCardsMainStackView.addArrangedSubview(categoorieCardsSecondtColumnStackView)
        view.addSubview(categoorieCardsMainStackView)
        
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
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.055).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.height * 0.045).isActive = true
        
        pageHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        pageHeaderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageHeaderLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.13).isActive = true
        
        categoorieCardsMainStackView.translatesAutoresizingMaskIntoConstraints = false
        categoorieCardsMainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        categoorieCardsMainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.3).isActive = true
    }
    
    private func setupUI() {
        pageHeaderLabel.text = "CATEGORY"
        if let descriptor = UIFont.systemFont(ofSize: 30).fontDescriptor.withSymbolicTraits([.traitBold, .traitItalic]) {
            pageHeaderLabel.font = UIFont(descriptor: descriptor, size: 30)
        }
        pageHeaderLabel.textColor = .white
        
        categoorieCardsFirstColumnStackView.axis = .vertical
        categoorieCardsFirstColumnStackView.spacing = view.frame.height * 0.045
        
        categoorieCardsSecondtColumnStackView.axis = .vertical
        categoorieCardsSecondtColumnStackView.spacing = view.frame.height * 0.045
        
        categoorieCardsMainStackView.axis = .horizontal
        categoorieCardsMainStackView.spacing = view.frame.height * 0.045
    }
    
    private func setupButtonActions() {
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)

        categoorieCardsFirstColumnStackView.arrangedSubviews.forEach { button in
            if let button = button as? UIButton {
                button.addTarget(self, action: #selector(categoryButtonPressed(_:)), for: .touchUpInside)
            }
        }
        
        categoorieCardsSecondtColumnStackView.arrangedSubviews.forEach { button in
            if let button = button as? UIButton {
                button.addTarget(self, action: #selector(categoryButtonPressed(_:)), for: .touchUpInside)
            }
        }
    }

    @objc private func categoryButtonPressed(_ sender: UIButton) {

        guard let stackView = sender.subviews.first(where: { $0 is UIStackView }) as? UIStackView,
              let label = stackView.arrangedSubviews.first(where: { $0 is UILabel }) as? UILabel else { return }
        
        let categoryName = label.text ?? ""

        if let selectedCategory = quizCategories.first(where: { $0.name == categoryName }) {
            let gameView = GameView()
            gameView.selectedCategory = selectedCategory
            gameView.modalPresentationStyle = .fullScreen
            present(gameView, animated: true, completion: nil)
        } else {
            print("Category not found in quizCategories") // Если категория не найдена
        }
    }

    @objc private func backButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
}
