//
//  TableViewSectionModel.swift
//  swifty-companion
//
//  Created by Anastasia on 16.08.2021.
//

import Foundation

enum SectionType {
    case peerSkills
    case peerProjects
    
    var title: String {
        switch self {
        case .peerSkills: return "Skills"
        case .peerProjects: return "Projects"
        }
    }
}
