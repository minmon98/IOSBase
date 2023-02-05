//
//  Constant.swift
//  IOSBase
//
//  Created by Minh Mon on 30/12/2022.
//

import Foundation


enum TimeoutTime {
    static let timeout = 60.0
}

enum Host {
    static let devHost = ""
    static let stagingHost = ""
    static let productionHost = ""
}

enum NetworkError {
    static let commonError = -1
    static let timeOutError = -2
}
