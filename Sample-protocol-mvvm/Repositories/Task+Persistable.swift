//
//  TaskPersistable.swift
//  Sample-protocol-mvvm
//
//  Created by NishiokaKohei on 2017/05/18.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation
import RealmSwift

extension Task: Persistable {

    // MARK: - Mapping

    init(managedObject: TaskObject) {
        name = managedObject.name
        date = managedObject.date
        content = managedObject.content
    }

    func managedObject() -> TaskObject {
        let object = TaskObject()
        object.name = name
        object.date = date
        object.content = content
        return object
    }

    enum PropertyValue: PropertyValueType {
        case id(Int)
        case name(String)
        case date(String)
        case content(String)

        public var propertyValuePair: PropertyValuePair {
            switch self {
            case .id(let id):
                return ("id", id)
            case .name(let name):
                return ("name", name)
            case .date(let date):
                return ("date", date)
            case .content(let content):
                return ("content", content)
            }
        }
    }

    enum Query: QueryType {
        case primaryKey(Int)
        case taskName(String)

        public var predicate: NSPredicate? {
            switch self {
            case .primaryKey(let ID):
                return NSPredicate(format: "id == %d", ID)
            case .taskName(let value):
                return NSPredicate(format: "name == %@", value)
            }
        }

        public var sortDescriptors: [SortDescriptor] {
            return [SortDescriptor.init(keyPath: "name", ascending: true)]
        }
    }
    
}
