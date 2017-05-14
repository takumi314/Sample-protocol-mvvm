//
//  SampleViewModel.swift
//  Sample-protocol-mvvm
//
//  Created by NishiokaKohei on 2017/05/15.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

class SampleViewModel: CellRepresentable {

    // MARK: - Internal propeties

    var sampleModel: SampleModel

    var price: String {
        guard let price = sampleModel.price else {
            return "No data"
        }
        return "\(price)"
    }

    var rowHeight: CGFloat {
        get {
            return 70.0
        }
    }


    // MARK: - Initializer

    init(sampleModel: SampleModel) {
        self.sampleModel = sampleModel
    }


    // MARK: - Internal methods

    func cellInstance(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        // Dequeue a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! SampleTableViewCell

        // Pass ourselves (the view model) to setup the cell
        cell.setup(viewModel: self)

        // Return the cell
        return cell
    }

}
