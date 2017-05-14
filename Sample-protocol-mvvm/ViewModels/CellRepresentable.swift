//
//  CellRepresentable.swift
//  Sample-protocol-mvvm
//
//  Created by NishiokaKohei on 2017/05/15.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

protocol CellRepresentable {
    var rowHeight: CGFloat { get }
    func cellInstance(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}
