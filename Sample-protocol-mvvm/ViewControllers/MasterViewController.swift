//
//  MasterViewController.swift
//  Sample-protocol-mvvm
//
//  Created by NishiokaKohei on 2017/05/18.
//  Copyright © 2017年 Kohey. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    // IBOutlets

    @IBOutlet weak var masterNavigationBar: UINavigationBar!
    @IBOutlet weak var masterTitle: UINavigationItem!
    @IBOutlet weak var masterTableView: UITableView!

    // Init an empty cell representable array
    var data = [CellRepresentable]()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        masterTitle.title = "Title"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Actions

    @IBAction func didTapRightBarButton(_ sender: UIBarButtonItem) {
        //
    }

}

// MARK: - UITableViewDataSource

extension MasterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return data[indexPath.row].cellInstance(tableView, indexPath: indexPath)
    }
}


// MARK: - UITableViewDelegate

extension MasterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return data[indexPath.row].rowHeight
    }
}
