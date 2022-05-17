//
//  TableCellConfiguratorProtocol.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 18.02.2022.
//

import CoreGraphics

protocol TableCellConfiguratorProtocol: ViewConfiguratorProtocol {
    static var id: String { get }
    var cellHeight: CGFloat { get }
}
