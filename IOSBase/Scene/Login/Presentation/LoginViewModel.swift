//
//  LoginViewModel.swift
//  IOSBase
//
//  Created by Minh Mon on 02/01/2023.
//

import Foundation
import RxSwift

class LoginViewModel: BaseViewModel {
    var input: Input
    var output: Output
    var processor: Processor
    private let useCase = LoginUseCase()
    var disposeBag = DisposeBag()
    
    struct Input {
        let username: AnyObserver<String?>
        let password: AnyObserver<String?>
        let didTapLogin: AnyObserver<Void>
    }
    
    struct Output {
        let isLoading: Observable<Bool>
        let error: Observable<Error>
        let userInfo: Observable<UserInfo>
    }
    
    struct Processor {
        let isLoading = PublishSubject<Bool>()
        let error = PublishSubject<Error>()
        let username = BehaviorSubject<String?>(value: nil)
        let password = BehaviorSubject<String?>(value: nil)
        let userInfo = PublishSubject<UserInfo>()
        let didTapLogin = PublishSubject<Void>()
    }
    
    init() {
        processor = Processor()
        input = Input(
            username: processor.username.asObserver(),
            password: processor.password.asObserver(),
            didTapLogin: processor.didTapLogin.asObserver()
        )
        output = Output(
            isLoading: processor.isLoading.asObservable(),
            error: processor.error.asObservable(),
            userInfo: processor.userInfo.asObservable()
        )
        observeInput()
    }
    
    func observeInput() {
        disposeBag.insert([
            processor.didTapLogin
                .withLatestFrom(processor.username)
                .withLatestFrom(processor.password) { ($0 ?? "", $1 ?? "") }
                .subscribe(onNext: { [weak self] in
                    self?.login(param: $0)
                })
        ])
    }
    
    private func login(param: (String, String)) {
        processor.isLoading.onNext(true)
        self.useCase.execute(param: param)
            .observe(on: Dependencies.shared.mainScheduler)
            .subscribe(on: Dependencies.shared.backgroundScheduler)
            .subscribe(onNext: { [weak self] in
                self?.processor.userInfo.onNext($0)
            }, onError: { [weak self] in
                self?.processor.error.onNext($0)
            })
            .disposed(by: disposeBag)
    }
}
