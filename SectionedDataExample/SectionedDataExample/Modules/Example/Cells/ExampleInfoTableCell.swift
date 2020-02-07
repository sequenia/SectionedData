//
//  ExampleInfoTableCell.swift
//  SectionedDataExample
//
//  Created by Tabriz Dzhavadov on 12/04/2019.
//  Copyright © 2019 Tabriz Dzhavadov. All rights reserved.
//

import UIKit
import SectionedData

class ExampleInfoTableCellData: BaseTableCellData, DiffComparable {

    var name: String?

    init(_ name: String) {
        super.init(UUID().uuidString.hashValue)
        self.name = name
    }
    
    func isEqual(lhs: BaseTableCellData, rhs: BaseTableCellData) -> Bool {
        guard let rhs = (rhs as? ExampleInfoTableCellData), let lhs = (lhs as? ExampleInfoTableCellData) else { return true }
        return lhs.identifier == rhs.identifier && lhs.name == rhs.name
    }
}

class ExampleInfoTableCell: UITableViewCell {

    private var data: ExampleInfoTableCellData?

    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }


    func bind(_ data: ExampleInfoTableCellData?) {
        self.data = data

        self.label.text = self.data?.name
    }

}
