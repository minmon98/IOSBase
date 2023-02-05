//
//  Mapper.swift
//  IOSBase
//
//  Created by Minh Mon on 02/01/2023.
//

import Foundation

protocol Mapper: AnyObject {
    associatedtype DM
    associatedtype EM
    
    func map(from object: DM) -> EM
}
