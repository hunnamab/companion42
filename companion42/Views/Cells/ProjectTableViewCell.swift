//
//  ProjectTableViewCell.swift
//  swifty-companion
//
//  Created by Anastasia on 20.08.2021.
//

import UIKit

final class ProjectTableViewCell: UITableViewCell {
    static let defaultId = UUID().uuidString
    
    lazy var projectNameLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFont.light.of(size: 14)
        label.textColor = .raisinBlack
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    lazy var pointsLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFont.light.of(size: 14)
        label.textColor = .raisinBlack
        label.isHidden = true
        
        return label
    }()
    
    lazy var projectStatusImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.alignment = .fill
        view.isLayoutMarginsRelativeArrangement = true
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 4,
                                                                leading: 16,
                                                                bottom: 4,
                                                                trailing: 16)
        
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.createViews()
        self.createConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.createViews()
        self.createConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.pointsLabel.isHidden = true
        self.pointsLabel.text = ""
    }
    
    private func createViews() {
        self.contentView.addSubview(self.stackView)
        
        self.stackView.addArrangedSubview(self.projectNameLabel)
        self.stackView.addArrangedSubview(self.pointsLabel)
        self.stackView.addArrangedSubview(self.projectStatusImageView)
    }
    
    private func createConstraints() {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

}
