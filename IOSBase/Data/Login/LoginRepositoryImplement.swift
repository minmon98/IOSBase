//
//  LoginRepositoryImplement.swift
//  IOSBase
//
//  Created by Minh Mon on 02/01/2023.
//

import Foundation
import RxSwift

class LoginRepositoryImplement: LoginRepository {
    func login(username: String, password: String) -> Observable<UserInfo> {
        return LoginApi(username: username, password: password)
            .request()
            .map {
                LoginMapper().map(from: $0.data)
            }
    }
}
