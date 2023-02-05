//
//  LoginMapper.swift
//  IOSBase
//
//  Created by Minh Mon on 02/01/2023.
//

import Foundation

class LoginMapper: Mapper {
    typealias DM = LoginResponseEntity.UserInfoEntity?
    typealias EM = UserInfo
    
    func map(from object: LoginResponseEntity.UserInfoEntity?) -> UserInfo {
        var userInfo = UserInfo()
        userInfo.id = object?.id
        userInfo.name = object?.name
        userInfo.email = object?.email
        userInfo.token = object?.token
        return userInfo
    }
}
