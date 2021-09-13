//
//  ProfileView.swift
//  swifty-companion
//
//  Created by Anastasia on 13.08.2021.
//

import UIKit

final class ProfileView: UIView {
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width,
                                         height: UIScreen.main.bounds.height + 200)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        
        return scrollView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 32
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.isScrollEnabled = false
        
        return tableView
    }()
    
    lazy var profileStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .fill
        view.backgroundColor = .raisinBlack.withAlphaComponent(0.5)
        view.spacing = 16
        view.isLayoutMarginsRelativeArrangement = true
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8,
                                                                leading: 8,
                                                                bottom: 8,
                                                                trailing: 8)
        view.layer.cornerRadius = 8
        view.isUserInteractionEnabled = false
        
        return view
    }()
    
    lazy var mainInfoStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        view.alignment = .center
        view.isUserInteractionEnabled = false
        
        return view
    }()
    
    lazy var additionalInfoStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 12
        view.alignment = .fill
        view.distribution = .fillProportionally
        view.isUserInteractionEnabled = false
        
        return view
    }()
    
    lazy var avatarContainerView = makeContainerView()
    
    lazy var avatarImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 43
        view.layer.masksToBounds = true
        
        return view
    }()
    
    lazy var progressContainerView = makeContainerView()
    
    lazy var progressView: CustomProgressView = {
        let view = CustomProgressView()
        view.progressTintColor = .turquoise
        
        return view
    }()
    
    lazy var loginLabel = makeLabel(fontSize: 24, textColor: .turquoise)
    lazy var nameLabel = makeLabel(fontSize: 18, textColor: .powderWhite)
    lazy var emailLabel = makeLabel(fontSize: 14, textColor: .powderWhite)
    lazy var locationLabel = makeLabel(fontSize: 14, textColor: .powderWhite)
    
    lazy var walletLabel = makeLabel(fontSize: 18, textColor: .turquoise)
    lazy var pointsLabel = makeLabel(fontSize: 18, textColor: .turquoise)
    lazy var cursusLabel = makeLabel(fontSize: 18, textColor: .turquoise)
    lazy var gradeLabel = makeLabel(fontSize: 18, textColor: .turquoise)
    
    lazy var progressLabel = makeLabel(fontSize: 14, textColor: .powderWhite)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.createViews()
        self.createConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.createViews()
        self.createConstraints()
    }
    
    private func makeLabel(fontSize: CGFloat, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        label.font = CustomFont.medium.of(size: fontSize)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.numberOfLines = 1
        
        return label
    }
    
    private func makeContainerView() -> UIView {
        let view = UIView()
        
        return view
    }
    
    private func createViews() {
        if let backgroundImage = UIImage(named: "background") {
            self.backgroundColor = UIColor(patternImage: backgroundImage)
        } else {
            self.backgroundColor = .powderWhite
        }
        
        self.addSubview(self.scrollView)
        
        self.scrollView.addSubview(self.profileStackView)
        self.scrollView.addSubview(self.tableView)
        
        self.avatarContainerView.addSubview(self.avatarImageView)
        
        self.progressContainerView.addSubview(self.progressView)
        self.progressContainerView.addSubview(self.progressLabel)
        
        self.mainInfoStackView.addArrangedSubview(self.nameLabel)
        self.mainInfoStackView.addArrangedSubview(self.loginLabel)
        self.mainInfoStackView.addArrangedSubview(self.emailLabel)
        self.mainInfoStackView.addArrangedSubview(self.locationLabel)
        
        self.additionalInfoStackView.addArrangedSubview(self.walletLabel)
        self.additionalInfoStackView.addArrangedSubview(self.pointsLabel)
        self.additionalInfoStackView.addArrangedSubview(self.cursusLabel)
        self.additionalInfoStackView.addArrangedSubview(self.gradeLabel)
        
        self.profileStackView.addArrangedSubview(self.avatarContainerView)
        self.profileStackView.addArrangedSubview(self.mainInfoStackView)
        self.profileStackView.addArrangedSubview(self.additionalInfoStackView)
        self.profileStackView.addArrangedSubview(self.progressContainerView)
    }
    
    private func createConstraints() {
        let constant = CGFloat(8)
        
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        self.avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.avatarImageView.heightAnchor.constraint(equalToConstant: 86),
            self.avatarImageView.widthAnchor.constraint(equalToConstant: 86),
            self.avatarImageView.topAnchor.constraint(equalTo: self.avatarContainerView.topAnchor),
            self.avatarImageView.bottomAnchor.constraint(equalTo: self.avatarContainerView.bottomAnchor),
            self.avatarImageView.centerXAnchor.constraint(equalTo: self.avatarContainerView.centerXAnchor)
        ])
        
        self.progressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.progressView.topAnchor.constraint(equalTo: self.progressContainerView.topAnchor, constant: constant),
            self.progressView.leadingAnchor.constraint(equalTo: self.progressContainerView.leadingAnchor, constant: constant),
            self.progressView.trailingAnchor.constraint(equalTo: self.progressContainerView.trailingAnchor, constant: -constant),
            self.progressView.bottomAnchor.constraint(equalTo: self.progressContainerView.bottomAnchor, constant: -constant),
            self.progressView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        self.progressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.progressLabel.centerYAnchor.constraint(equalTo: self.progressContainerView.centerYAnchor),
            self.progressLabel.centerXAnchor.constraint(equalTo: self.progressContainerView.centerXAnchor)
        ])
        
        self.profileStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.profileStackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 16),
            self.profileStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: constant),
            self.profileStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -constant)
        ])
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.profileStackView.bottomAnchor, constant: 16),
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func setData(for peer: Peer) {
        let avatarString = peer.avatar
        if let avatarUrl = URL(string: avatarString) {
            if let data = NSData(contentsOf: avatarUrl) {
                self.avatarImageView.image = UIImage(data: data as Data)
            }
        }
        
        self.loginLabel.text = peer.login
        self.nameLabel.text = peer.name
        self.emailLabel.text = peer.email
        self.locationLabel.text = "\(peer.campus.city), \(peer.campus.country)"
        
        self.walletLabel.text = "\(peer.wallet) ₳"
        self.pointsLabel.text = "\(peer.correctionPoints) points"
        
        if peer.cursus.cursusName.isEmpty == true {
            self.cursusLabel.isHidden = true
        } else {
            self.cursusLabel.text = peer.cursus.cursusName
        }

        if peer.cursus.grade.isEmpty == true {
            self.gradeLabel.isHidden = true
        } else {
            self.gradeLabel.text = peer.cursus.grade
        }
        
        let progress = peer.cursus.level.remainder(dividingBy: 10)
        self.progressView.setProgress(progress, animated: false)
        
        self.progressLabel.text = "level \(peer.cursus.level)%"
        
    }
}
