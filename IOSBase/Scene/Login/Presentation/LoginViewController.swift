//
//  LoginViewController.swift
//  IOSBase
//
//  Created by Minh Mon on 02/01/2023.
//

import UIKit

class LoginViewController: BaseViewController {
    var viewModel = LoginViewModel()
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupViewModels() {
        let input = viewModel.input
        disposeBag.insert([
            usernameTextField.rx.text.bind(to: input.username),
            passwordTextField.rx.text.bind(to: input.password),
            loginButton.rx.tap.map { _ in}.bind(to: input.didTapLogin)
        ])
        
        let output = viewModel.output
        disposeBag.insert([
            output.isLoading
                .subscribe(onNext: { [weak self] in
                    if $0 {
                        self?.showLoading()
                    } else {
                        self?.hideLoading()
                    }
                }),
            output.error
                .subscribe(onNext: { [weak self] in
                    self?.showError(error: $0)
                }),
            output.userInfo
                .subscribe(onNext: { [weak self] in
                    self?.showAlert(message: $0.name ?? "")
                })
        ])
    }
}
