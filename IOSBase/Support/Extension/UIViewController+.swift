//
//  UIViewController+.swift
//  IOSBase
//
//  Created by Minh Mon on 02/01/2023.
//

import Foundation
import UIKit
import SVProgressHUD

extension UIViewController {
    func showLoading() {
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.show(withStatus: "loading.title".localized())
    }
    
    func hideLoading() {
        SVProgressHUD.dismiss()
    }
    
    func showAlert(
        title: String = "alert.title".localized(),
        message: String,
        okTitle: String = "action.ok".localized(),
        cancelTitle: String? = nil,
        okCompletion: ((UIAlertAction) -> Void)? = nil,
        cancelCompletion: ((UIAlertAction) -> Void)? = nil
    ) {
        hideLoading()
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let cancelTitle = cancelTitle {
            let cancelAction = UIAlertAction(title: cancelTitle, style: .destructive, handler: cancelCompletion)
            alertController.addAction(cancelAction)
        }
        let okAction = UIAlertAction(title: okTitle, style: .default, handler: okCompletion)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
    
    func showError(error: Error, okCompletion: ((UIAlertAction) -> Void)? = nil) {
        hideLoading()
        let alertController = UIAlertController(title: "error.common".localized(), message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "action.ok".localized(), style: .default, handler: okCompletion)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
}
