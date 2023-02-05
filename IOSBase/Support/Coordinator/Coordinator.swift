//
//  Coordinator.swift
//  IOSBase
//
//  Created by Minh Mon on 02/01/2023.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    
    func start()
}
