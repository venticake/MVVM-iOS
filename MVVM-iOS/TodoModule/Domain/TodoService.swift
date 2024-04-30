//
//  TodoService.swift
//  MVVM-iOS
//
//  Created by BYUNGWOOK JEONG on 4/30/24.
//

import Foundation

struct TodoService {

    func fetchTodos() async -> [Todo] {
        let todos: [Todo] = [
            Todo(title: "temp title 1", content: "temp content 1"),
            Todo(title: "temp title 2", content: "temp content 2"),
            Todo(title: "temp title 3", content: "temp content 3"),
            Todo(title: "temp title 4", content: "temp content 4"),
            Todo(title: "temp title 5", content: "temp content 5")
        ]

        return todos
    }

    func addTodo(_ todo: Todo, to todos: [Todo]) -> [Todo] {
        return [todo] + todos
    }

    func removeTodo(id: String, from todos: [Todo]) -> [Todo] {
        return todos.filter { $0.id != id }
    }
}
