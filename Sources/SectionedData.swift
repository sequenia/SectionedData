//
//  SectionedData.swift
//  Domopult
//
//  Created by Tabriz Dzhavadov on 31/03/2019.
//  Copyright © 2019 Tabriz Dzhavadov. All rights reserved.
//

import DifferenceKit

public protocol ExtDifferentiable: Differentiable {
    func raw() -> Int
}

public extension ExtDifferentiable {

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.raw() == rhs.raw()
    }

    public static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.raw() < rhs.raw()
    }

}

public class SectionedData<SectionEnum: ExtDifferentiable> {

    public init() {
        
    }

    public private(set) var items = [ArraySection<SectionEnum, BaseTableCellData>]() {
        didSet {
            self.items.sort { (lhs, rhs) -> Bool in
                return lhs.model < rhs.model
            }
        }
    }

    // MARK: - Data Source

    public func numberOfSections() -> Int {
        return self.items.count
    }

    public func numberOfItemsIn(_ section: Int) -> Int {
        return self.items[section].elements.count
    }

    public func itemAt(_ indexPath: IndexPath) -> BaseTableCellData {
        return self.items[indexPath.section].elements[indexPath.row]
    }

    public func typeAt(_ indexPath: IndexPath) -> SectionEnum {
        return self.items[indexPath.section].model
    }

    // MARK: - Modifying

    public func clear() {
        self.items.removeAll()
    }

    public func removeAllBy(_ section: SectionEnum) {
        self.items.removeAll { $0.model == section }
    }

    public func hasItemsIn(_ section: SectionEnum) -> Bool {
        return self.items.filter { $0.model == section }.count > 0
    }

    public func append(_ item: ArraySection<SectionEnum, BaseTableCellData>) {
        self.items.append(item)
    }

    public func reload(_ data: [ArraySection<SectionEnum, BaseTableCellData>]) {
        self.items = data
    }

}

open class BaseTableCellData: Differentiable {

    public var identifier: Int

    public init(_ identifier: Int) {
        self.identifier = identifier
    }

    public var differenceIdentifier: Int {
        return self.identifier
    }

    public func isContentEqual(to source: BaseTableCellData) -> Bool {
        return self == source
    }

    static func == (lhs: BaseTableCellData, rhs: BaseTableCellData) -> Bool {
        return lhs.identifier == rhs.identifier
    }

}
