//
//  SkillTableViewCell.swift
//  swifty-companion
//
//  Created by Anastasia on 20.08.2021.
//

import UIKit

final class SkillTableViewCell: UITableViewCell {
    static let defaultId = UUID().uuidString
    
    lazy var skillNameLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFont.light.of(size: 14)
        label.textColor = .raisinBlack
        
        return label
    }()
    
    lazy var skillLevelLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFont.light.of(size: 14)
        label.textColor = .raisinBlack
        
        return label
    }()
    
    lazy var skillProgressView: UIProgressView = {
        let view = UIProgressView()
        view.progressTintColor = .turquoise
        
        return view
    }()
    
    lazy var labelsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.alignment = .fill
        
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
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
    
    private func createViews() {
        self.contentView.addSubview(self.stackView)
        
        self.stackView.addArrangedSubview(self.labelsStackView)
        self.stackView.addArrangedSubview(self.skillProgressView)
        
        self.labelsStackView.addArrangedSubview(self.skillNameLabel)
        self.labelsStackView.addArrangedSubview(self.skillLevelLabel)
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
