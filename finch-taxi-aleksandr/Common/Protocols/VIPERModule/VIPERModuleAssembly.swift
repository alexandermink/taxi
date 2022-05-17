//
//  Assembly.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 03.02.2022.
//

import UIKit

typealias Module = UIViewController

protocol Assembly {
    static func assembleModule(with model: TransitionModel) -> Module
    static func assembleModule() -> Module
}

extension Assembly {
    
    static func assembleModule(with model: TransitionModel) -> Module {
        fatalError("Реализуй метод assembleModule(with model: TransitionModel)")
    }
    
    static func assembleModule() -> Module {
        fatalError("Реализуй метод assembleModule()")
    }
    
}
