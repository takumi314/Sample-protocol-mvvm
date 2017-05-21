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
/// The infrastructure to insert or update, delete Task values inside a write transacion.
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

    // MARK: Updates

    func update<T: Persistable>(_ type: T.Type, values: [T.PropertyValue]) {
        var dictionary: [String: Any] = [:]
        values.forEach {
            let pair = $0.propertyValuePair
            dictionary[pair.name] = pair.value
        }
        realm.create(T.ManagedObject.self, value: dictionary, update: true)
    }

    // MARK: - Delete

    func delete<T: Persistable>(_ value: T) {
        realm.delete(value.managedObject())
    }

}

struct FetchedResults<T: Persistable> {

    let results: Results<T.ManagedObject>

    var count: Int {
        return results.count
    }

    internal init(results: Results<T.ManagedObject>) {
        self.results = results
    }

    func value(at index: Int) -> T {
        return T(managedObject: results[index])
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

    func values<T: Persistable> (_ type: T.Type, matching query: T.Query) -> FetchedResults<T> {
        var results = realm.objects(T.ManagedObject.self)
        if let predicate = query.predicate {
            results = results.filter(predicate)
        }
        results = results.sorted(by: query.sortDescriptors)
        return FetchedResults(results: results)
    }

    func allValues<T: Persistable>(_ type: T.Type) -> FetchedResults<T> {
        let objects = realm.objects(T.ManagedObject.self)
        return FetchedResults(results: objects)
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













