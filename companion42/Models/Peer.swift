//
//  Peer.swift
//  swifty-companion
//
//  Created by Anastasia on 14.08.2021.
//

import Foundation
import SwiftyJSON

struct Peer {
    let name: String
    let email: String
    let login: String
    let wallet: Int
    let correctionPoints: Int
    let avatar: String
    
    let cursus: Cursus
    let campus: Campus
    
    var projects: [Project]
    var skills: [Skill]
    
    init(json: JSON) {
        self.name = json["displayname"].stringValue
        self.email = json["email"].stringValue
        self.login = json["login"].stringValue
        self.wallet = json["wallet"].intValue
        self.correctionPoints = json["correction_point"].intValue
        self.avatar = json["image_url"].stringValue
        
        let city = json["campus"][0]["city"].stringValue
        let country = json["campus"][0]["country"].stringValue
        
        self.campus = Campus(city: city,
                             country: country)
        
        let cursus = Cursus.detectCursus(json: json)
        
        self.skills = []
        self.projects = []
        
        guard let currentCursus = cursus else {
            self.cursus = Cursus(grade: "", cursusName: "", level: Float.zero, id: 0)
            return
        }

        let cursusName = currentCursus["cursus"]["name"].stringValue
        let grade = currentCursus["grade"].stringValue
        let level = currentCursus["level"].floatValue
        let id = currentCursus["cursus"]["id"].intValue
        
        self.cursus = Cursus(grade: grade,
                             cursusName: cursusName,
                             level: level,
                             id: id)
        
        for (_, skillJson): (String, JSON) in currentCursus["skills"] {
            let skill = Skill(level: skillJson["level"].floatValue, skillName: skillJson["name"].stringValue)
            self.skills.append(skill)
        }
        
        for (_, projectJson): (String, JSON) in json["projects_users"] {
            let cursusId = projectJson["cursus_ids"][0].intValue
            if cursusId == 21 || cursusId == 1 || cursusId == self.cursus.id {
                
                let parentId = projectJson["project"]["parent_id"].int
                if parentId == nil {

                    if let projectStatus = ProjectStatus(rawValue: projectJson["status"].stringValue)
                       , projectStatus != .creatingGroup {
                        
                        let project = Project(finalMark: projectJson["final_mark"].int,
                                              status: projectStatus,
                                              projectName: projectJson["project"]["name"].stringValue,
                                              isValidated: projectJson["validated?"].bool)
                        
                        self.projects.append(project)
                        
                    }
                    
                }
                
            }
        }
    }
}
