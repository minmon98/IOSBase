//
//  Dependencies.swift
//  IOSBase
//
//  Created by Minh Mon on 02/01/2023.
//

import Foundation
import RxSwift
import RxCocoa

class Dependencies {
    
    let mainScheduler = MainScheduler.instance
    let backgroundScheduler : ImmediateSchedulerType = {
        return ConcurrentDispatchQueueScheduler(qos: .userInteractive)
    }()
    
    static let shared = Dependencies()
}
