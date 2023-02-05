//
//  LoginRepository.swift
//  IOSBase
//
//  Created by Minh Mon on 02/01/2023.
//

import Foundation
import RxSwift

protocol LoginRepository: AnyObject {
    func login(username: String, password: String) -> Observable<UserInfo>
}
