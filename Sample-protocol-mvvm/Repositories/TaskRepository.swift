//
//  TaskRepository.swift
//  Sample-protocol-mvvm
//
//  Created by NishiokaKohei on 2017/05/17.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation
import RealmSwift

struct TaskRepository: Repository {
    typealias Domain = TaskObject

    func find(ID: UInt) -> TaskObject? {
        let realm = try! Realm()
        return realm.objects(TaskObject.self).filter("ID == %d", ID).first
    }

    func findAll() -> [TaskObject] {
        let realm = try! Realm()
        return realm.objects(TaskObject.self).flatMap { $0 as TaskObject }
    }

}
