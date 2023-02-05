//
//  UseCase.swift
//  IOSBase
//
//  Created by Minh Mon on 02/01/2023.
//

import Foundation

protocol UseCase: AnyObject {
    associatedtype DM
    associatedtype EM
    
    func execute(param: DM) -> EM
}
