//
//  ViewController.swift
//  swifty-companion
//
//  Created by Anastasia on 13.08.2021.
//

import UIKit

final class SearchViewController: UIViewController {
    weak var searchTextField: UITextField?
    weak var searchButton: UIButton?
    weak var errorLabel: UILabel?
    
    private let child = SpinnerViewController()
    
    override func loadView() {
        self.view = SearchView()
        
        if let view = self.view as? SearchView {
            self.searchTextField = view.searchTextField
            self.searchButton = view.searchButton
            self.errorLabel = view.errorLabel
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true,
                                                          animated: false)
        
        self.searchButton?.addTarget(self, action: #selector(self.searchPeer(_:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true,
                                                          animated: false)
    }
    
    @objc private func searchPeer(_ sender: UIButton) {
        guard let peerLogin = self.searchTextField?.text?.trimmingCharacters(in: .whitespacesAndNewlines)
              , peerLogin.isEmpty == false else {
            self.errorLabel?.text = "Empty login field"
            self.errorLabel?.isHidden = false
            return
        }
        
        self.errorLabel?.isHidden = true
        
        APIManager.shared.getToken { isSuccess in
            if isSuccess == true {
                self.createSpinnerView()
                
                APIManager.shared.searchUser(user: peerLogin) { peer in
                    self.removeSpinnerView()
                    guard let peerProfile = peer else {
                        self.errorLabel?.text = "Can't load profile"
                        self.errorLabel?.isHidden = false
                        return
                    }
                    let profileVC = ProfileViewController(peer: peerProfile)
                    profileVC.modalPresentationStyle = .fullScreen
                    self.navigationController?.pushViewController(profileVC,
                                                                  animated: true)
                }
                
            } else {
                self.errorLabel?.text = "Error catching token"
                self.errorLabel?.isHidden = false
            }
        }
    }
    
    private func createSpinnerView() {
        self.addChild(self.child)
        self.child.view.frame = view.frame
        self.view.addSubview(self.child.view)
        self.child.didMove(toParent: self)
    }
    
    private func removeSpinnerView() {
        self.child.willMove(toParent: nil)
        self.child.view.removeFromSuperview()
        self.child.removeFromParent()
    }
}

