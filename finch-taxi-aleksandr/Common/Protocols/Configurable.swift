//
//  Configurable.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 17.02.2022.
//

protocol Configurable {
    
    associatedtype Model
    
    func configure(with model: Model)
}
