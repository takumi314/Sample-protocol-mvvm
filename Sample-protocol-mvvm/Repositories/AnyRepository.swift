//
//  AnyRepository.swift
//  Sample-protocol-mvvm
//
//  Created by NishiokaKohei on 2017/05/17.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import Foundation

protocol Repository {
    associatedtype Domain

    func find(ID: UInt) -> Domain?
    func findAll() -> [Domain]
}

// MARK: - For Partial Updates

public typealias PropertyValuePair = (name: String, value: Any)

public protocol PropertyValueType {
    var propertyValuePair: PropertyValuePair { get }
}
