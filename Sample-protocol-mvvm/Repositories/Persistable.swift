//
//  Persistable.swift
//  Sample-protocol-mvvm
//
//  Created by NishiokaKohei on 2017/05/17.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation
import RealmSwift

///
/// The mechanism to transform our struct based models into their corresponding Realm objects.
///

protocol Persistable {
    associatedtype ManagedObject: RealmSwift.Object
    associatedtype PropertyValue: PropertyValueType
    associatedtype Query: QueryType

    init(managedObject: ManagedObject)
    func managedObject() -> ManagedObject
}

// MARK: - For Partial Updates

public typealias PropertyValuePair = (name: String, value: Any)

public protocol PropertyValueType {
    var propertyValuePair: PropertyValuePair { get }
}

// MARK: - The internal representation of a query

public protocol QueryType {
    var predicate: NSPredicate? { get }
    var sortDescriptors: [SortDescriptor] { get }
}
