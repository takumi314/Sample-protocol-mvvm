//
//  MasterTableViewCell.swift
//  Sample-protocol-mvvm
//
//  Created by NishiokaKohei on 2017/05/18.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

class MasterTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    func setup(viewModel: MasterViewModel) {
        titleLabel.text = viewModel.task.name
        contentLabel.text = viewModel.content
    }

}
