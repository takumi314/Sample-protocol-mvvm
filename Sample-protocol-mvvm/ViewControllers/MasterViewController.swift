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
                                      message: "What is new task with you ?",
                                      preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel) {(action: UIAlertAction) -> () in }
        let defaultAction = UIAlertAction(title: "OK",
                                          style: .default) { [weak self] (action: UIAlertAction) in
                                                self?.executeOKAction(alert)
                                            }
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        alert.addTextField(configurationHandler: { (text: UITextField) in
            text.placeholder = "Task name"
            text.tag = 1
        })
        alert.addTextField() { (content: UITextField) in
            content.placeholder = "Content"
            content.tag = 2
        }
        alert.addTextField() { (date: UITextField) in
            date.placeholder = "Due date"
            date.tag = 3
        }

        present(alert, animated: true, completion: nil)
    }

    func isInvalid<T: UITextField>(_ textFields: [T]?) -> Bool {
        guard let textFeilds = textFields else {
            return true
        }
        if textFeilds.filter({ $0.validation() }).count != textFeilds.count {
            return true
        }
        return false
    }

    func executeOKAction(_ alert: UIAlertController) {
        if isInvalid(alert.textFields) {
            return
        }
        guard let task = setInputValue(of: alert.textFields) else {
            return
        }
        register(task)
        fetchAll()
        masterTableView.reloadData()
    }

    func setInputValue(of textFields: [UITextField]?) -> Task? {
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
        return task
    }

    func register(_ task: Task?) {
        guard let task = task else {
            return
        }
        let container = try? Container()
        try? container?.write { transaction in
            transaction.add(task, update: false)
        }
    }

    func fetchAll() {
        let container = try! Container()
        data = container
                .allValues(Task.self)
                .results.flatMap {
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
