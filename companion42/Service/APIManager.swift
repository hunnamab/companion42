//
//  APIManager.swift
//  swifty-companion
//
//  Created by Anastasia on 14.08.2021.
//

import Foundation
import Alamofire
import SwiftyJSON

final public class APIManager {
    static let shared = APIManager()
    
    private let tokenUrl = "https://api.intra.42.fr/oauth/token"
    private let config = [
        "grant_type": "client_credentials",
        "client_id": "7d729ab1e0e1962299aaaf63b221d34af1577c942fd1d7fc9b3f62e28a869fbc",
        "client_secret": "b8aeed879fc0d62525af23eaa3f0ceda5c9b1f44fa539ec6a572a12e8ff71862"]
    
    private var token: String?
    
    func getToken(completion: @escaping (Bool) -> Void) {
        let existingToken = UserDefaults.standard.object(forKey: "token")
        if existingToken == nil {
            AF.request(tokenUrl,
                       method: .post,
                       parameters: config)
                .validate()
                .responseDecodable(of: AccessToken.self) { response in
                    guard let credentials = response.value else {
                        print(response.error?.localizedDescription ?? "Unknown error")
                        return completion(false)
                    }
                    self.token = credentials.accessToken
                    UserDefaults.standard.set(credentials.accessToken, forKey: "token")
                    self.checkTokenValidity { isCompleted in
                        completion(isCompleted)
                    }
                }
        } else {
            self.token = existingToken as? String
            self.checkTokenValidity { isCompleted in
                completion(isCompleted)
            }
        }
    }
    
    private func checkTokenValidity(completion: @escaping (Bool) -> Void) {
        guard let token = self.token else {
            return
        }
        
        let url = URL(string: "https://api.intra.42.fr/oauth/token/info")
        let bearer = "Bearer" + " " + token
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue(bearer, forHTTPHeaderField: "Authorization")
        
        AF.request(request as URLRequestConvertible).validate().responseJSON {
            response in
            switch response.result {
            case .success:
                completion(true)
            case .failure:
                UserDefaults.standard.removeObject(forKey: "token")
                self.getToken { isCompleted in
                    completion(isCompleted)
                }
            }
        }
    }
    
    func searchUser(user: String, completion: @escaping (Peer?) -> Void) {
        guard let token = self.token
              , let userUrl = URL(string: "https://api.intra.42.fr/v2/users/" + user) else {
            return
        }

        let bearer = "Bearer" + " " + token
        
        var request = URLRequest(url: userUrl)
        request.httpMethod = "GET"
        request.setValue(bearer, forHTTPHeaderField: "Authorization")
        
        AF.request(request as URLRequestConvertible).validate().responseJSON {
                    response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        let peer = Peer(json: json)
                        completion(peer)
                    case .failure:
                        completion(nil)
                        print("Error: This login doesn't exists")
                    }
                }
    }
}
