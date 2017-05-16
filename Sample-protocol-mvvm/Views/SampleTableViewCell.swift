//
//  SampleTableViewCell.swift
//  Sample-protocol-mvvm
//
//  Created by NishiokaKohei on 2017/05/15.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

class SampleTableViewCell: UITableViewCell {
    func setup(viewModel: SampleViewModel) {
        self.textLabel?.text = viewModel.sampleModel.name
        self.detailTextLabel?.text = viewModel.sampleModel.date
    }
}
