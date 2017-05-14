//
//  SampleViewModel.swift
//  Sample-protocol-mvvm
//
//  Created by NishiokaKohei on 2017/05/15.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

class SampleViewModel: CellRepresentable {

    var rowHeight: CGFloat {
        get {
            return 70.0
        }
    }

    func cellInstance(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        // Dequeue a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)

        // Pass ourselves (the view model) to setup the cell


        // Return the cell
        return cell
    }

}
