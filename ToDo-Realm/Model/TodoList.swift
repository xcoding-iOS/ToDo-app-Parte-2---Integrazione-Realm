//
//  TodoList.swift
//  ToDo-Realm
//
//  Created by Giuseppe Sapienza on 09/04/2019.
//  Copyright © 2019 Giuseppe Sapienza. All rights reserved.
//

import RealmSwift

struct RealmTodoList {

    init() throws {
        self.realm = try Realm.init()
        print("🤖 Realm:", Realm.Configuration.defaultConfiguration.fileURL ?? "")
    }
    
    fileprivate let realm: Realm
    fileprivate let elements: [Todo] = []
    
    func add(todo: Todo) throws {
        try self.realm.write {
            self.realm.add(todo)
        }
    }
    
    
    func getAll(priority: Priority? = nil) -> [Todo] {
        
        let results: Results<Todo>
        
        if let selectedPriority = priority {
            results = self.realm.objects(Todo.self).filter("priority == \(selectedPriority.rawValue)")
        } else {
            results = self.realm.objects(Todo.self)
        }
        
        guard !results.isEmpty else {
            return []
        }
        
        return Array.init(results)
    }
    
    
}
