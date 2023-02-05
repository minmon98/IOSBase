//
//  BaseViewModel.swift
//  IOSBase
//
//  Created by Minh Mon on 02/01/2023.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

protocol BaseViewModel: AnyObject {
    associatedtype Input // define input sequences
    associatedtype Output // define output sequences
    associatedtype Processor // define observer and observable
    
    var input: Input { get set }
    var output: Output { get set }
    var processor: Processor { get set }
    var disposeBag: DisposeBag { get set }
    
    /**
     Transform input to output
     output listener
     */
    func observeInput()
}
