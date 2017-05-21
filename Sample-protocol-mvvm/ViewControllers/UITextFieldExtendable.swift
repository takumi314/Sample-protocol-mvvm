//
//  UITextFieldExtendable.swift
//  Sample-protocol-mvvm
//
//  Created by NishiokaKohei on 2017/05/20.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

protocol UITextFieldExtendable {
    func validation() -> Bool
}

extension UITextField: UITextFieldExtendable {
    func validation() -> Bool {
        guard let text = self.text else {
            return false
        }
        if text.isEmpty {
            return false
        }
        // Anything else
        return true
    }
}
