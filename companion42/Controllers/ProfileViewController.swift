//
//  ProfileViewController.swift
//  swifty-companion
//
//  Created by Anastasia on 13.08.2021.
//

import UIKit

final class ProfileViewController: UIViewController {
    weak var selfView: ProfileView?
    weak var scrollView: UIScrollView?
    weak var tableView: UITableView?
    
    private var peer: Peer
    private var sections: [Section] = []
    
    private let contentViewOffset = CGFloat(200)
    
    init(peer: Peer) {
        self.peer = peer
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = ProfileView()
        
        if let view = self.view as? ProfileView {
            self.selfView = view
            self.scrollView = view.scrollView
            self.tableView = view.tableView
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureNavBar()
        
        // Scroll View
        self.scrollView?.delegate = self
        
        // Table View
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.register(SkillTableViewCell.self,
                                 forCellReuseIdentifier: SkillTableViewCell.defaultId)
        self.tableView?.register(ProjectTableViewCell.self,
                                 forCellReuseIdentifier: ProjectTableViewCell.defaultId)
        
        self.selfView?.setData(for: peer)
        self.createSections()
    }
    
    private func configureNavBar() {
        self.navigationController?.setNavigationBarHidden(false,
                                                          animated: false)
        self.navigationItem.title = "Profile"
        let backButton = UIBarButtonItem(image: UIImage(named: "back_icon")?.withRenderingMode(.alwaysTemplate),
                                         style: .plain,
                                         target: self, action: #selector(self.dismissController))
        backButton.tintColor = .turquoise
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func dismissController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func createSections() {
        if self.peer.projects.isEmpty == false {
            self.sections.append(Section(sectionType: .peerProjects, isCollapsed: true))
        }
        if self.peer.skills.isEmpty == false {
            self.sections.append(Section(sectionType: .peerSkills, isCollapsed: true))
        }
        self.tableView?.reloadData()
    }

}

extension ProfileViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y

        if scrollView == self.scrollView {
            self.tableView?.isScrollEnabled = (yOffset >= self.contentViewOffset)
        }

        if scrollView == self.tableView {
            self.tableView?.isScrollEnabled = (yOffset > 0)
        }
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
            as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        
        header.titleLabel.text = sections[section].sectionType.title
        header.section = section
        header.delegate = self
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.sections[section].isCollapsed == true {
            return 0
        } else {
            switch self.sections[section].sectionType {
            case .peerProjects:
                return self.peer.projects.count
            case .peerSkills:
                return self.peer.skills.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.sections[indexPath.section].isCollapsed ? 0 : UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.sections[indexPath.section].sectionType {
        case .peerProjects:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ProjectTableViewCell.defaultId,
                                                        for: indexPath) as? ProjectTableViewCell {
                self.configure(cell: cell, atIndexPath: indexPath)
                
                return cell
            }
        case .peerSkills:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SkillTableViewCell.defaultId,
                                                        for: indexPath) as? SkillTableViewCell {
                self.configure(cell: cell, atIndexPath: indexPath)
                
                return cell
            }
        }
        return UITableViewCell()
    }
}

extension ProfileViewController {
    private func configure(cell: ProjectTableViewCell, atIndexPath: IndexPath) {
        let project = peer.projects[atIndexPath.row]
        
        cell.projectNameLabel.text = project.projectName
        
        if project.status == .inProgress {
            cell.projectStatusImageView.image = UIImage(named: "in_progress")?.withRenderingMode(.alwaysTemplate)
            cell.projectStatusImageView.tintColor = .gray
        } else if project.status == .finished {
            cell.pointsLabel.isHidden = false
            if project.isValidated == false {
                cell.projectStatusImageView.image = UIImage(named: "failed")?.withRenderingMode(.alwaysTemplate)
                cell.projectStatusImageView.tintColor = .systemRed
                
                cell.pointsLabel.text = "\(project.finalMark ?? 0)"
            } else if project.isValidated == true {
                cell.projectStatusImageView.image = UIImage(named: "done")?.withRenderingMode(.alwaysTemplate)
                cell.projectStatusImageView.tintColor = .green
                
                cell.pointsLabel.text = "\(project.finalMark ?? 0)"
            }
            
        }
        
    }
    
    private func configure(cell: SkillTableViewCell, atIndexPath: IndexPath) {
        cell.skillNameLabel.text = peer.skills[atIndexPath.row].skillName
        cell.skillLevelLabel.text = "\(peer.skills[atIndexPath.row].level)%"
        
        let progress = peer.skills[atIndexPath.row].level / 100 * 3.3
        cell.skillProgressView.setProgress(progress, animated: false)
    }
}

extension ProfileViewController: CollapsibleTableViewHeaderDelegate {
    func toggleSection(header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !sections[section].isCollapsed

        self.sections[section].isCollapsed = collapsed
        self.tableView?.reloadSections(IndexSet(integer: section), with: .automatic)
    }
}
