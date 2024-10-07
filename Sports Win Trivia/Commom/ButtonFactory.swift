import UIKit

class ButtonFactory {
    
    var isSoundEnabled: Bool = false
    
    static func createButton(type: ButtonType, title: String?) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        switch type {
        case .primaryButton:
            button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .heavy)
            button.layer.cornerRadius = 18
            button.titleLabel?.textAlignment = .center
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 52).isActive = true
            button.widthAnchor.constraint(equalToConstant: 180).isActive = true
            
        case .secondaryButton(let letter):
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
            button.layer.cornerRadius = 18
            button.setTitle("\(title ?? "")", for: .normal)
            
            let label = UILabel()
            label.text = letter
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
            label.textColor = .white
            
            button.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
            label.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 20).isActive = true
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: 260).isActive = true
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
        case .categoryButton(let text, let icon):
            let label = UILabel()
            label.text = text
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 24)
            label.textColor = .white
            label.numberOfLines = 0
            
            let imageView = UIImageView(image: icon)
            imageView.contentMode = .scaleAspectFit
            
            let stackView = UIStackView(arrangedSubviews: [label, imageView])
            stackView.isUserInteractionEnabled = false
            stackView.axis = .vertical
            stackView.alignment = .center
            stackView.distribution = .fillEqually
            
            button.addSubview(stackView)
            
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
            stackView.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
            stackView.widthAnchor.constraint(equalTo: button.widthAnchor).isActive = true
            stackView.heightAnchor.constraint(equalTo: button.heightAnchor, multiplier: 0.9).isActive = true
            
            button.layer.cornerRadius = 10
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: 130).isActive = true
            button.heightAnchor.constraint(equalToConstant: 130).isActive = true
            
        case .backButton:
            button.layer.cornerRadius = 10
            
            let imageView = UIImageView(image: UIImage(named: "backArrowIcon"))
            imageView.contentMode = .scaleAspectFit
            
            button.addSubview(imageView)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 38).isActive = true
            button.widthAnchor.constraint(equalToConstant: 40).isActive = true
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
            imageView.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        }
        
        return button
    }
    
    @objc private static func buttonClicked() {
            SoundManager.shared.playClickSound()
    }
    
    enum ButtonType {
        case primaryButton
        case secondaryButton(letter: String?)
        case categoryButton(text: String, icon: UIImage?)
        case backButton
    }
    
}

