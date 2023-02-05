//
//  LoginCoordinator.swift
//  IOSBase
//
//  Created by Minh Mon on 02/01/2023.
//

import Foundation
import UIKit

class LoginCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
        let loginViewModel = LoginViewModel()
        loginViewController.viewModel = loginViewModel
        navigationController.setViewControllers([loginViewController], animated: true)
    }
}
