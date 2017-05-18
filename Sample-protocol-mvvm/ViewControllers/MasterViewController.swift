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
        masterTableView.delegate = self
        masterTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Actions

    @IBAction func didTapRightBarButton(_ sender: UIBarButtonItem) {
        //textの表示はalertのみ。ActionSheetだとtextfiledを表示させようとすると
        //落ちます。
        let alert = UIAlertController(title:"action",
                                      message: "alertView",
                                      preferredStyle: UIAlertControllerStyle.alert)

        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel) { (action: UIAlertAction) in print("Cancel") }
        let defaultAction = UIAlertAction(title: "OK",
                                          style: .default) { (action: UIAlertAction) in print("OK") }
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        //textfiledの追加
        alert.addTextField(configurationHandler: {(text: UITextField) in
            //対象UITextFieldが引数として取得できる
            text.placeholder = "Task name"
        })
        //実行した分textfiledを追加される。
        alert.addTextField() { (content: UITextField) in
            content.placeholder = "Content"
        }
        alert.addTextField() { (date: UITextField) in
            date.placeholder = "Dur date"
        }

        let register = { [weak self] in

            self?.masterTableView.reloadData()
        }


        present(alert, animated: true, completion: register as? () -> Void)
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
