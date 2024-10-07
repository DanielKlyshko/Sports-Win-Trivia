import UIKit

class LeaderboardTableCustomCell: UITableViewCell {
    
    let cellBackgroundView = UIView()
    private let cellNumberLabel = UILabel()
    private let userNameLabel = UILabel()
    private let userScoreLabel = UILabel()
    let topUserMedalImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: "LeaderboardTableCustomCell")
        
        contentView.addSubview(cellBackgroundView)
        cellBackgroundView.addSubview(cellNumberLabel)
        cellBackgroundView.addSubview(userNameLabel)
        cellBackgroundView.addSubview(userScoreLabel)
        cellBackgroundView.addSubview(topUserMedalImage)
        
        setupContraints()
        setupUI()
    }
    
    private func setupContraints() {
        cellBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        cellBackgroundView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        cellBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        cellBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25).isActive = true
        cellBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
        cellBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        
        cellNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        cellNumberLabel.centerYAnchor.constraint(equalTo: cellBackgroundView.centerYAnchor).isActive = true
        cellNumberLabel.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor, constant: 20).isActive = true

        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.centerYAnchor.constraint(equalTo: cellBackgroundView.centerYAnchor).isActive = true
        userNameLabel.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor, constant: 60).isActive = true
        userNameLabel.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        userScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        userScoreLabel.centerYAnchor.constraint(equalTo: cellBackgroundView.centerYAnchor).isActive = true
        userScoreLabel.leadingAnchor.constraint(equalTo: userNameLabel.trailingAnchor, constant: 20).isActive = true
        
        topUserMedalImage.translatesAutoresizingMaskIntoConstraints = false
        topUserMedalImage.centerYAnchor.constraint(equalTo: cellBackgroundView.centerYAnchor).isActive = true
        topUserMedalImage.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor, constant: -30).isActive = true
    }
    
    private func setupUI() {
        cellBackgroundView.layer.cornerRadius = 18
        
        cellNumberLabel.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        cellNumberLabel.textColor = .white
        
        userNameLabel.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        userNameLabel.textColor = .white
        
        userScoreLabel.font = UIFont.systemFont(ofSize: 22, weight: .heavy)
        userScoreLabel.textColor = .white
    }
    
    func configure(with user: User, position: Int) {
        cellNumberLabel.text = "\(position)."
        userNameLabel.text = user.username
        userScoreLabel.text = "\(user.score)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
