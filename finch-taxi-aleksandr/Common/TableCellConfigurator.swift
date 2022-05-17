//
//  TableCellConfigurator.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 18.02.2022.
//

import UIKit

struct TableCellConfigurator<CellType: Configurable, Model>: TableCellConfiguratorProtocol
where CellType: UITableViewCell, CellType.Model == Model {
    
    // MARK: - Properties
    
    static var id: String {
        String(describing: CellType.self)
    }
    
    var cellHeight: CGFloat
    
    let model: Model
    
    
    // MARK: - Init
    
    init(model: Model, cellHeight: CGFloat = UITableView.automaticDimension) {
        self.model = model
        self.cellHeight = cellHeight
    }
    
    
    // MARK: - Public methods
    
    func configure(_ view: UIView) {
        (view as? CellType)?.configure(with: model)
    }
    
}
