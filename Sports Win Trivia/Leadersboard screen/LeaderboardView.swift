
import UIKit

class LeaderboardView: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    var viewModel: LeaderboardViewModel!
    
    private let backButton = ButtonFactory.createButton(type: .backButton, title: "")
    private let pageHeaderLabel = UILabel()
    let leaderboardTable = UITableView()
    
    var users: [User] = predefinedUsers.sorted { $0.score > $1.score }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLayer = CAGradientLayer.createDarkBlueGradient()
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        view.addSubview(backButton)
        view.addSubview(pageHeaderLabel)
        view.addSubview(leaderboardTable)
        
        leaderboardTable.dataSource = self
        leaderboardTable.delegate = self
        leaderboardTable.register(LeaderboardTableCustomCell.self, forCellReuseIdentifier: "LeaderboardTableCustomCell")
        
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
        
        leaderboardTable.translatesAutoresizingMaskIntoConstraints = false
        leaderboardTable.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.24).isActive = true
        leaderboardTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        leaderboardTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        leaderboardTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func setupUI() {
        pageHeaderLabel.text = "LEADERBOARD"
        if let descriptor = UIFont.systemFont(ofSize: 30).fontDescriptor.withSymbolicTraits([.traitBold, .traitItalic]) {
            pageHeaderLabel.font = UIFont(descriptor: descriptor, size: 30)
        }
        pageHeaderLabel.textColor = .white
        
        leaderboardTable.backgroundColor = .clear
        leaderboardTable.separatorStyle = .none
    }
    
    func reloadTable() {
        leaderboardTable.reloadData()
    }
    
    private func setupButtonActions() {
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }

    @objc private func backButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderboardTableCustomCell", for: indexPath) as! LeaderboardTableCustomCell

        cell.selectionStyle = .none
        
        if indexPath.row < 3 {
            cell.cellBackgroundView.backgroundColor = UIColor.systemBlue
            switch indexPath.row {
            case 0:
                cell.topUserMedalImage.image = UIImage(named: "goldMedalIcon")
            case 1:
                cell.topUserMedalImage.image = UIImage(named: "silverMedalIcon")
            case 2:
                cell.topUserMedalImage.image = UIImage(named: "bronzeMedalIcon")
            default:
                cell.topUserMedalImage.image = nil
            }
        } else {
            cell.cellBackgroundView.backgroundColor = UIColor.black
            cell.topUserMedalImage.image = nil
        }
        
        let user = users[indexPath.row]
        cell.configure(with: user, position: indexPath.row + 1)
        cell.backgroundColor = .clear
        
        return cell
    }
}
