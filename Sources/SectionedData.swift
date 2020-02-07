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
    
    public func itemsAt(_ section: SectionEnum) -> [BaseTableCellData] {
        var items = [BaseTableCellData]()
        self.items.forEach { (item) in
            if item.model == section {
                items.append(contentsOf: item.elements)
            }
        }
        return items
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
    
    public func replace(_ item: ArraySection<SectionEnum, BaseTableCellData>) {
        self.removeAllBy(item.model)
        self.append(item)
    }
    
    public func appendOrReplace(_ item: ArraySection<SectionEnum, BaseTableCellData>) {
        let tempItem = self.items.filter { (model) -> Bool in
            return model.model == item.model
            }.first
        
        if tempItem != nil {
            self.replace(item)
            return
        }
        
        self.append(item)
    }
    
    public func replaceData(_ data: BaseTableCellData, section: SectionEnum) {
        var items = [BaseTableCellData]()
        self.items.forEach { (item) in
            if item.model == section {
                items.append(contentsOf: item.elements)
            }
        }
        
        var item = items.filter { $0.identifier == data.identifier }.first
        item = data
    }
    
    public func reload(_ data: [ArraySection<SectionEnum, BaseTableCellData>]) {
        self.items.removeAll()
        self.items = data
    }
}

public protocol DiffComparable {
    func isEqual(lhs: BaseTableCellData, rhs: BaseTableCellData) -> Bool
}

open class BaseTableCellData: Differentiable {
    
    public var identifier: Int
    
    public init(_ identifier: Int) {
        self.identifier = identifier
    }
    
    public var differenceIdentifier: Int {
        return self.identifier
    }
    
    open func isContentEqual(to source: BaseTableCellData) -> Bool {
        return self == source
    }
    
    static func == (lhs: BaseTableCellData, rhs: BaseTableCellData) -> Bool {
        if let tempLhs = lhs as? DiffComparable {
            return tempLhs.isEqual(lhs: lhs, rhs: rhs)
        }
        return true
    }
}
