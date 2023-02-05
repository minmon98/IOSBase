//
//  ApiClient.swift
//  IOSBase
//
//  Created by Minh Mon on 30/12/2022.
//

import Alamofire
import RxSwift
import RxCocoa
import Localize_Swift

class ApiTimeOut {
    static let shared = ApiTimeOut()
    var timer: Timer?
}

class ApiClient {
    private lazy var manager: SessionManager = {
        var configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeoutTime.timeout
        configuration.timeoutIntervalForResource = TimeoutTime.timeout
        return Alamofire.SessionManager(configuration: configuration)
    }()
    private let disposeBag = DisposeBag()
    static let shared = ApiClient()
    
    private init() { }
    
    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        params: Parameters?,
        headers: HTTPHeaders?
    ) -> Observable<T> {
        let requestUrl = Environment.shared.host + endpoint
        return callApi(
            url: requestUrl,
            method: method,
            params: params,
            headers: headers
        )
    }
    
    private func callApi<T: Decodable>(
        url: String,
        method: HTTPMethod,
        params: Parameters?,
        headers: HTTPHeaders?
    ) -> Observable<T> {
        let onRefresh = PublishSubject<Void>()
        var weakObserver: AnyObserver<T>?
        
        let disposable = Observable<T>.create { observer in
            weakObserver = observer
            self.managerRequest(
                observer: observer,
                onRefresh: onRefresh.asObserver(),
                url: url,
                method: method,
                params: params,
                headers: headers
            )
            
            return Disposables.create()
        }
        
        onRefresh
            .subscribe(onNext: { [weak self] in
                // MARK: Call refresh api first then
                self?.managerRequest(
                    observer: weakObserver,
                    onRefresh: onRefresh.asObserver(),
                    url: url,
                    method: method,
                    params: params,
                    headers: headers
                )
            })
            .disposed(by: disposeBag)
        
        return disposable
    }
    
    private func managerRequest<T: Decodable>(
        observer: AnyObserver<T>?,
        onRefresh: AnyObserver<Void>?,
        url: String,
        method: HTTPMethod,
        params: Parameters?,
        headers: HTTPHeaders?
    ) {
        ApiTimeOut.shared.timer?.invalidate()
        ApiTimeOut.shared.timer = nil
        ApiTimeOut.shared.timer = Timer.scheduledTimer(withTimeInterval: TimeoutTime.timeout, repeats: false) { _ in
            ApiTimeOut.shared.timer?.invalidate()
            ApiTimeOut.shared.timer = nil
            observer?.onError(NSError(domain: "error.timeout".localized(), code: NetworkError.timeOutError))
            observer?.onCompleted()
        }
        let defaultHeaders: HTTPHeaders = [
            "Authorization": "Bearer " + (AppSessionManager.shared.token ?? ""),
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        self.manager.request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers: headers ?? defaultHeaders)
            .responseData { response in
                print("== Url ==")
                print(url)
                print("== Method ==")
                print(method)
                print("== Params ==")
                print(params as Any)
                print("== Headers == ")
                print((headers ?? defaultHeaders) as Any)
                print("== Response ==")
                print(response)
                switch response.result {
                case .success(_):
                    guard let httpResponse = response.response else { return }
                    if 200...400 ~= httpResponse.statusCode {
                        do {
                            guard let data = response.data else { return }
                            let object = try JSONDecoder().decode(T.self, from: data)
                            observer?.onNext(object)
                            observer?.onCompleted()
                        } catch let error {
                            observer?.onError(error)
                            observer?.onCompleted()
                        }
                    } else {
                        // MARK: - Expired token case
                        if httpResponse.statusCode == 401 {
                            onRefresh?.onNext(())
                            return
                        }
                        observer?.onError(NSError(domain: "error.network".localized(), code: NetworkError.commonError))
                        observer?.onCompleted()
                    }
                    
                case .failure(let error):
                    observer?.onError(error)
                    observer?.onCompleted()
                }
            }
    }
}
