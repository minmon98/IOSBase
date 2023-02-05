//
//  BaseViewController.swift
//  IOSBase
//
//  Created by Minh Mon on 02/01/2023.
//

import Foundation
import UIKit
import RxSwift

class BaseViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupViewModels()
    }
    
    func setupViews() {}
    
    func setupViewModels() {}
}
