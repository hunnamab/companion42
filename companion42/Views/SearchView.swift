//
//  MainView.swift
//  swifty-companion
//
//  Created by Anastasia on 13.08.2021.
//

import UIKit

final class SearchView: UIView {
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        view.alignment = .fill
        
        return view
    }()
    
    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        
        textField.font = CustomFont.light.of(size: 17)
        textField.textColor = .powderWhite
        textField.backgroundColor = .black.withAlphaComponent(0.3)
        
        let placeholder = NSAttributedString(string: "Login",
                                             attributes: [.font : CustomFont.italic.of(size: 17),
                                                          .foregroundColor: UIColor.powderWhite.withAlphaComponent(0.5)])
        textField.attributedPlaceholder = placeholder
        
        textField.borderStyle = .none
        
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.turquoise.cgColor
        textField.layer.cornerRadius = 6
        
        textField.leftView = UIView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: 8,
                                                  height: self.frame.height))
        textField.leftViewMode = .always
        
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        
        return textField
    }()
    
    lazy var searchButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Search", for: .normal)
        btn.titleLabel?.font = CustomFont.medium.of(size: 20)
        btn.titleLabel?.tintColor = .powderWhite
        btn.backgroundColor = .turquoise
        btn.layer.cornerRadius = 6
        
        return btn
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.font = CustomFont.light.of(size: 14)
        label.textAlignment = .center
        
        return label
    }()
    
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
    
    private func createViews() {
        if let backgroundImage = UIImage(named: "background") {
            self.backgroundColor = UIColor(patternImage: backgroundImage)
        } else {
            self.backgroundColor = .powderWhite
        }
        
        self.addSubview(self.stackView)
        
        self.stackView.addArrangedSubview(self.searchTextField)
        self.stackView.addArrangedSubview(self.searchButton)
        self.stackView.addArrangedSubview(self.errorLabel)
        
        self.errorLabel.isHidden = true
    }
    
    private func createConstraints() {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.centerYAnchor, constant: -48),
            self.stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.stackView.widthAnchor.constraint(equalToConstant: 256)
        ])
        
        self.searchTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.searchTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        self.searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.searchButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
