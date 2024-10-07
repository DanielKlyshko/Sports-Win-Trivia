import UIKit

class SettingsView: UIViewController {
    
    var viewModel: SettingsViewModel!
    
    private let backButton = ButtonFactory.createButton(type: .backButton, title: "")
    private let pageHeaderLabel = UILabel()
    
    private let sounndLabel = UILabel()
    private let soundSwitch = UISwitch()
    private let soundsStack = UIStackView()
    
    private let darkThemeLabel = UILabel()
    private let darkThemeSwitch = UISwitch()
    private let darkThemeStack = UIStackView()
    
    private let mainSettingsStack = UIStackView()
    
    private let ressetProgressButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLayer = CAGradientLayer.createDarkBlueGradient()
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        view.addSubview(backButton)
        view.addSubview(pageHeaderLabel)
        
        soundsStack.addArrangedSubview(sounndLabel)
        soundsStack.addArrangedSubview(soundSwitch)
        
        darkThemeStack.addArrangedSubview(darkThemeLabel)
        darkThemeStack.addArrangedSubview(darkThemeSwitch)
        
        mainSettingsStack.addArrangedSubview(soundsStack)
        mainSettingsStack.addArrangedSubview(darkThemeStack)
        view.addSubview(mainSettingsStack)
        
        view.addSubview(ressetProgressButton)
        
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
        
        mainSettingsStack.translatesAutoresizingMaskIntoConstraints = false
        mainSettingsStack.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.4).isActive = true
        mainSettingsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainSettingsStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        ressetProgressButton.translatesAutoresizingMaskIntoConstraints = false
        ressetProgressButton.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.75).isActive = true
        ressetProgressButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ressetProgressButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        ressetProgressButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupUI() {
        pageHeaderLabel.text = "SETTINGS"
        if let descriptor = UIFont.systemFont(ofSize: 30).fontDescriptor.withSymbolicTraits([.traitBold, .traitItalic]) {
            pageHeaderLabel.font = UIFont(descriptor: descriptor, size: 30)
        }
        pageHeaderLabel.textColor = .white
        
        sounndLabel.text = "SOUNDS"
        if let descriptor = UIFont.systemFont(ofSize: 22).fontDescriptor.withSymbolicTraits([.traitBold, .traitItalic]) {
            sounndLabel.font = UIFont(descriptor: descriptor, size: 22)
        }
        sounndLabel.textColor = .white
        
        soundSwitch.onTintColor = UIColor.init(red: 0, green: 123/255, blue: 1, alpha: 1)
        soundSwitch.thumbTintColor = UIColor.init(red: 0, green: 51/255, blue: 102/255, alpha: 1)
        soundSwitch.backgroundColor = UIColor.init(red: 224/255, green: 224/255, blue: 224/255, alpha: 1)
        soundSwitch.layer.cornerRadius = soundSwitch.frame.height / 2
        soundSwitch.layer.borderColor = UIColor.white.cgColor
        soundSwitch.layer.borderWidth = 2
        soundSwitch.layer.masksToBounds = true
        soundSwitch.addTarget(self, action: #selector(soundSwitchToggled(_:)), for: .valueChanged)
        soundSwitch.isOn = SoundManager.shared.isSoundEnabled
        
        darkThemeLabel.text = "DARK THEME"
        if let descriptor = UIFont.systemFont(ofSize: 22).fontDescriptor.withSymbolicTraits([.traitBold, .traitItalic]) {
            darkThemeLabel.font = UIFont(descriptor: descriptor, size: 22)
        }
        darkThemeLabel.textColor = .white
        
        darkThemeSwitch.isOn = true
        darkThemeSwitch.onTintColor = UIColor.init(red: 0, green: 123/255, blue: 1, alpha: 1)
        darkThemeSwitch.thumbTintColor = UIColor.init(red: 0, green: 51/255, blue: 102/255, alpha: 1)
        darkThemeSwitch.backgroundColor = UIColor.init(red: 224/255, green: 224/255, blue: 224/255, alpha: 1)
        darkThemeSwitch.layer.cornerRadius = soundSwitch.frame.height / 2
        darkThemeSwitch.layer.borderColor = UIColor.white.cgColor
        darkThemeSwitch.layer.borderWidth = 2
        darkThemeSwitch.layer.masksToBounds = true
        darkThemeSwitch.isEnabled = false
        
        soundsStack.axis = .horizontal
        
        darkThemeStack.axis = .horizontal
        
        mainSettingsStack.axis = .vertical
        mainSettingsStack.spacing = view.frame.height * 0.05
        
        ressetProgressButton.titleLabel?.text = "Reset progress"
        ressetProgressButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        ressetProgressButton.titleLabel?.textColor = .white
        
        ressetProgressButton.setTitle("Reset progress", for: .normal)
        ressetProgressButton.setTitleColor(.white, for: .normal)
        ressetProgressButton.setTitleColor(.systemGray2, for: .highlighted)
        ressetProgressButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .heavy)
        ressetProgressButton.backgroundColor = .systemBlue
        ressetProgressButton.layer.cornerRadius = 20
        ressetProgressButton.addTarget(self, action: #selector(ressetProgressButtonPressed), for: .touchUpInside)
    }
    
    private func setupButtonActions() {
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }

    @objc private func backButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func ressetProgressButtonPressed() {
        SoundManager.shared.playClickSound()
    }
    
    @objc private func soundSwitchToggled(_ sender: UISwitch) {
        if sender.isOn {
            SoundManager.shared.playBackgroundSound()
        } else {
            SoundManager.shared.stopBackgroundSound()
        }
        
        SoundManager.shared.isSoundEnabled = sender.isOn
    }
}
