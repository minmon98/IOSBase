//
//  Environment.swift
//  IOSBase
//
//  Created by Minh Mon on 30/12/2022.
//

import Foundation

class Environment {
    let host: String
    
    init(host: String) {
        self.host = host
    }
    
    static let shared: Environment = {
        #if DEBUG
        let environment = Environment(host: Host.devHost)
        
        #elseif STAGING
        let environment = Environment(host: Host.stagingHost)
        
        #elseif PRODUCTION
        let environment = Environment(host: Host.productionHost)
        
        #endif
        return environment
    }()
}
