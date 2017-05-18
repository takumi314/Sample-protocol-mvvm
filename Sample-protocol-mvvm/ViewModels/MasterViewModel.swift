//
//  MasterViewModel.swift
//  Sample-protocol-mvvm
//
//  Created by NishiokaKohei on 2017/05/18.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

class MasterViewModel: CellRepresentable {

    var rowHeight: CGFloat {
        get {
            return 50.0
        }
    }

    var task: Task
    var content: String {
        if task.content.isEmpty {
            return "No content"
        }
        return task.content
    }

    // MARK: - Initializer

    init(task: Task) {
        self.task = task
    }

    func cellInstance(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MasterCell", for: indexPath) as? MasterTableViewCell else {
            let newCell = MasterTableViewCell()
            newCell.setup(viewModel: self)
            return newCell
        }
        cell.setup(viewModel: self)
        return cell
    }

}
