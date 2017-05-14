//
//  SampleViewController.swift
//  Sample-protocol-mvvm
//
//  Created by NishiokaKohei on 2017/05/15.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

class SampleViewController: UIViewController {

    // all of the data in the array conforms to the CellRepresentable protocol,
    fileprivate var data = [CellRepresentable]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

// MARK: - UITableViewDataSource

extension SampleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return data[indexPath.row].cellInstance(tableView, indexPath: indexPath)
    }
}


// MARK: - UITableViewDelegate

extension SampleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return data[indexPath.row].rowHeight
    }
}
