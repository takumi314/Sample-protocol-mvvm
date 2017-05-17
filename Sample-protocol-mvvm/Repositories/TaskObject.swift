//
//  TaskObject.swift
//  Sample-protocol-mvvm
//
//  Created by NishiokaKohei on 2017/05/17.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation
import RealmSwift

final class TaskObject: Object {
    dynamic var id = 0
    dynamic var name: String = ""
    dynamic var date: String = ""
    dynamic var content: String = ""
    dynamic var created = NSDate()

    override static func primaryKey() -> String? {
        return "id"
    }
}
