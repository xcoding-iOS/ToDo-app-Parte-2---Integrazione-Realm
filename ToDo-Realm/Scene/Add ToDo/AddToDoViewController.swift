//
//  AddToDoViewController.swift
//  ToDo
//
//  Created by Giuseppe Sapienza on 11/03/2019.
//  Copyright © 2019 Giuseppe Sapienza. All rights reserved.
//

import UIKit

class AddToDoViewController: UIViewController {

    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var tagTextField: UITextField!
    
    @IBOutlet var priorityButtons: [UIButton]!
    
    var selectedPriority: Priority?
    var todoList: RealmTodoList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            self.todoList = try RealmTodoList.init()
        } catch let e {
            print("🤖", e)
        }

        for button in self.priorityButtons {
            guard let priority = Priority.init(rawValue: button.tag) else { return }
            button.backgroundColor = priority.color()
            button.layer.cornerRadius = button.frame.width/2
            button.alpha = 0.5
        }
        
    }

    @IBAction func addButton_clicked(_ sender: UIBarButtonItem) {
        print("🤖 \(#function)")
        
        guard
            let title = self.titleTextView.text,
            !title.isEmpty
        else {
            print("🤖 \(#function) title isEmpty")
            return
        }
        
        guard
            let tag = self.tagTextField.text,
            !tag.isEmpty
        else {
            print("🤖 \(#function) tag isEmpty")
            return
        }
        
        guard let priority = self.selectedPriority else {
            print("🤖 \(#function) priority nil")
            return
        }
        
        let todo = Todo.init()
        todo.title = title
        todo.tag = tag
        todo.priority = priority.rawValue
        
        do {
            try self.todoList?.add(todo: todo)
            self.navigationController?.popViewController(animated: true)
        } catch let e {
            print("🤖", e)
        }
        
    }
    
    @IBAction func priorityButton_clicked(_ sender: UIButton) {
        let selectedButton = sender.tag
        
        guard
            let priority = Priority.init(rawValue: selectedButton)
        else {
            return
        }
        
        self.selectedPriority = priority
        
        for button in self.priorityButtons {
            if (button == sender) {
                button.alpha = 1
            } else {
                button.alpha = 0.5
            }
            
        }
        
        print("🤖 \(#function) \(selectedButton) \(priority)")
    }
}

