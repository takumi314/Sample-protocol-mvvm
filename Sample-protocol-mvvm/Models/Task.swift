//
//  Task.swift
//  Sample-protocol-mvvm
//
//  Created by NishiokaKohei on 2017/05/17.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation

struct Task {
    var id = 0
    var name: String = ""
    var date: String = ""
    var content: String = ""
    var created: String = ""
}

// MARK: - Mapping

extension Task: Persistable {

    init(managedObject: TaskObject) {
        id = managedObject.id
        name = managedObject.name
        date = managedObject.date
        content = managedObject.content
    }

    func managedObject() -> TaskObject {
        let object = TaskObject()
        object.id = id
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

}
