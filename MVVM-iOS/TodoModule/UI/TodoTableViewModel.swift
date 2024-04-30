//
//  TodoTableViewModel.swift
//  MVVM-iOS
//
//  Created by BYUNGWOOK JEONG on 4/30/24.
//

import Foundation

@MainActor
final class TodoTableViewModel: ObservableObject {

    @Published private(set) var todos: [Todo] = []

    private let todoService = TodoService()

    init() {
        todos = [Todo(title: "alkefale", content: "alkenflae")]
//        Task {
//            let todos = await todoService.fetchTodos()
//            setTodos(todos)
//            print("todos \(todos.count)")
//        }
    }

    private func setTodos(_ todos: [Todo]) {
        self.todos = todos
    }

    func addTodo(_ todo: Todo) {
        let todos = todoService.addTodo(todo, to: todos)
        setTodos(todos)
    }

    func removeTodo(id: String) {
        todos = todoService.removeTodo(id: id, from: todos)
        setTodos(todos)
    }
}
