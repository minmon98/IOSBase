//
//  LoginUseCase.swift
//  IOSBase
//
//  Created by Minh Mon on 02/01/2023.
//

import Foundation
import RxSwift

class LoginUseCase: UseCase {
    typealias DM = (String, String)
    typealias EM = Observable<UserInfo>
    private let repository: LoginRepository = LoginRepositoryImplement()
    
    func execute(param: (String, String)) -> Observable<UserInfo> {
        let username = param.0
        let password = param.1
        return repository.login(username: username, password: password)
    }
}
