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
    var data: [CellRepresentable] = []

    var inputTask = Task()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        masterTitle.title = "Title"
        fetchAll()
        masterTableView.delegate = self
        masterTableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        masterTableView.reloadData()
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Actions

    @IBAction func didTapRightBarButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title:"Ragister",
                                      message: "What is new task tiwh you ?",
                                      preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel) {(action: UIAlertAction) in
                                            print("Cancel") }
        let defaultAction = UIAlertAction(title: "OK",
                                          style: .default) { [weak self] (action: UIAlertAction) in
                                                self?.executeOKAction(alert)
                                                print("OK")
        }
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)

        //textfiledの追加
        alert.addTextField(configurationHandler: { (text: UITextField) in
            //対象UITextFieldが引数として取得できる
            text.placeholder = "Task name"
            text.tag = 1
        })
        //実行した分textfiledを追加される。
        alert.addTextField() { (content: UITextField) in
            content.placeholder = "Content"
            content.tag = 2
        }
        alert.addTextField() { (date: UITextField) in
            date.placeholder = "Dur date"
            date.tag = 3
        }

        present(alert, animated: true, completion: nil)
    }

    func validation() -> Bool {
        let isValid = true
        // 文字数制限
        // 有効値
        return isValid
    }

    func executeOKAction(_ alert: UIAlertController) {
        if let task = setInputValue(alert.textFields) {
            register(task)
            fetchAll()
            masterTableView.reloadData()
        }
    }

    func setInputValue(_ textFields: [UITextField]?) -> Task? {
        guard let textFields = textFields else {
            return nil
        }
        var task = Task()
        let _ = textFields
            .flatMap { (textField: UITextField) in
                switch textField.tag {
                case 1:
                    task.name = textField.text ?? "No title"
                case 2:
                    task.content = textField.text ?? "No content"
                case 3:
                    task.date = textField.text ?? "No date"
                default: break
                }
        }
        print(task)
        return task
    }

    func register(_ task: Task) {
        // Validation

        let container = try? Container()
        try? container?.write { transaction in
            transaction.add(task, update: false)
        }
        fetchAll()
        masterTableView.reloadData()
    }

    func fetchAll() {
        let container = try! Container()
        data = container
                .values(Task.self, matching: .taskName(""))
                .results
                .flatMap {
                    MasterViewModel(task: Task(managedObject: $0))
                }
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
