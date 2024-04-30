//
//  TodoService.swift
//  MVVM-iOS
//
//  Created by BYUNGWOOK JEONG on 4/30/24.
//

import Foundation

struct TodoService {

    func fetchTodos(from: Int = 0, count: Int = 10) async -> [Todo] {
        var todos = [Todo]()

        for index in from..<from + count {
            let todo = Todo(title: "temp title \(index)", content: "temp content")
            todos.append(todo)
        }

        try? await Task.sleep(nanoseconds: 1_000_000_000) // 1.0 s

        return todos
    }

    func addTodo(_ todo: Todo, to todos: [Todo]) -> [Todo] {
        return [todo] + todos
    }

    func removeTodo(id: String, from todos: [Todo]) -> [Todo] {
        return todos.filter { $0.id != id }
    }
}
