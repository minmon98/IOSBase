//
//  LoginAPI.swift
//  IOSBase
//
//  Created by Minh Mon on 02/01/2023.
//

import Foundation
import Alamofire

class LoginApi: BaseApi<LoginResponseEntity> {
    private var username = ""
    private var password = ""
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    override func endpoint() -> String {
        return "/login"
    }
    
    override func method() -> HTTPMethod {
        return .post
    }
    
    override func params() -> Parameters? {
        return [
            "username": username,
            "password": password
        ]
    }
}
