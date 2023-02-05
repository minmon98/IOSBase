//
//  LoginEntity.swift
//  IOSBase
//
//  Created by Minh Mon on 02/01/2023.
//

import Foundation

struct LoginResponseEntity: Decodable {
    let status: Int?
    let data: UserInfoEntity?
    
    struct UserInfoEntity: Decodable {
        let id: Int?
        let token: String?
        let name: String?
        let email: String?
    }
}
