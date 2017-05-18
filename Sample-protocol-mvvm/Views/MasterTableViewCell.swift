//
//  MasterTableViewCell.swift
//  Sample-protocol-mvvm
//
//  Created by NishiokaKohei on 2017/05/18.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

class MasterTableViewCell: UITableViewCell {
    func setup(viewModel: MasterViewModel) {
        self.textLabel?.text = viewModel.task.name
        self.detailTextLabel?.text = viewModel.content
    }
}
