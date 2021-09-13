//
//  Cursus.swift
//  swifty-companion
//
//  Created by Anastasia on 15.08.2021.
//

import Foundation
import SwiftyJSON

struct Cursus {
    let grade: String
    let cursusName: String
    let level: Float
    let id: Int
    
    static func detectCursus(json: JSON) -> JSON? {
        var cursus = json["cursus_users"].arrayValue.first { cursus in
            if cursus["cursus"]["id"].intValue == 21 {
                return true
            }
            return false
        }
        
        if cursus == nil {
            
            cursus = json["cursus_users"].arrayValue.first { cursus in
                if cursus["cursus"]["id"].intValue == 1 {
                    return true
                }
                return false
            }
            
            if cursus == nil {
                
                cursus = json["cursus_users"].arrayValue.first { cursus in
                    if cursus["cursus"]["id"].intValue == 4 {
                        return true
                    }
                    return false
                }
                
                if cursus == nil {
                    
                    cursus = json["cursus_users"].arrayValue.first { cursus in
                        if cursus["level"].floatValue.isZero == false {
                            return true
                        }
                        return false
                    }
                    
                }
                
            }
        }
        return cursus
    }
}
