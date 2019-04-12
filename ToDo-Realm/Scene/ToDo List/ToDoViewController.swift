//
//  ViewController.swift
//  ToDo-Realm
//
//  Created by Giuseppe Sapienza on 11/03/2019.
//  Copyright © 2019 Giuseppe Sapienza. All rights reserved.
//

import UIKit

class ToDoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var todoList: RealmTodoList?
    var todoListObjects: [Todo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("🤖 \(#function)")
        do {
            self.todoList = try RealmTodoList.init()
            self.tableView.dataSource = self
        } catch let e {
            print("🤖", e)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("🤖 \(#function)")
        self.todoListObjects = self.todoList?.getAll() ?? []
        self.tableView.reloadData()
    }
    
    @IBAction func addButton_clicked(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "segueToAddViewController", sender: nil)
    }
    
    @IBAction func priorityFilter_selected(_ sender: UISegmentedControl) {
        print("🤖 \(#function)")
        let index = sender.selectedSegmentIndex - 1
        
        guard let priority = Priority.init(rawValue: index) else {
            self.todoListObjects = self.todoList?.getAll() ?? []
            self.tableView.reloadData()
            return
        }
        
        self.todoListObjects = self.todoList?.getAll(priority: priority) ?? []
        self.tableView.reloadData()
    
    }
    
}

extension ToDoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todoListObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todo = self.todoListObjects[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! ToDoTableViewCell
        cell.toDoTitleLabel.text = todo.title
        cell.toDoTagLabel.text = todo.tag
        cell.toDoPriorityView.backgroundColor = Priority.init(rawValue: todo.priority)?.color()
        return cell
    }
    
}

