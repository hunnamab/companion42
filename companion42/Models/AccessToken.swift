//
//  AccessToken.swift
//  swifty-companion
//
//  Created by Anastasia on 14.08.2021.
//

import Foundation

struct AccessToken: Decodable {
    let accessToken: String
    let tokenType: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
    }
}
