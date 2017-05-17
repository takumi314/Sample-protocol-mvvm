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


///
/// The infrastructure to insert Task values inside a write transacion.
///

struct WriteTransaction {

    private let realm: Realm

    internal init(realm: Realm) {
        self.realm = realm
    }

    // MARK: Creation

    func add<T: Persistable>(_ value: T, update: Bool) {
        realm.add(value.managedObject(), update: update)
    }
    
}

struct Container {

    private let realm: Realm

    init() throws {
        try self.init(realm: Realm())
    }

    init(realm: Realm) {
        self.realm = realm
    }

    func write(_ block: (WriteTransaction) throws -> Void) throws {
        let transaction = WriteTransaction(realm: realm)
        try realm.write {
            try block(transaction)
        }
    }

}

///  # A Sample process
///
///  let character = Character(
///      identifier: 1455,
///     name: "Iron Man",
///      realName: "Tony Stark",
///      publisher: Publisher(identifier: 1, name: "Marvel")
///  )
///
///  let container = try! Container()
///
///  try! container.write { transaction in
///      transaction.add(character)
///  }













