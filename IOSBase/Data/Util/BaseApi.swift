//
//  BaseApi.swift
//  IOSBase
//
//  Created by Minh Mon on 30/12/2022.
//

import Foundation
import Alamofire
import RxSwift

protocol BaseApiProtocol: AnyObject {
    associatedtype T
    
    func endpoint() -> String
    func method() -> HTTPMethod
    func params() -> Parameters?
    func headers() -> HTTPHeaders?
    func request() -> Observable<T>
}

class BaseApi<T: Decodable>: BaseApiProtocol {
    func endpoint() -> String {
        return ""
    }
    
    func method() -> HTTPMethod {
        return .get
    }
    
    func params() -> Parameters? {
        return nil
    }
    
    func headers() -> HTTPHeaders? {
        return nil
    }
    
    func request() -> Observable<T> {
        return ApiClient.shared.request(
            endpoint: endpoint(),
            method: method(),
            params: params(),
            headers: headers()
        )
    }
}
