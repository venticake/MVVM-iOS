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

    private var isFetching = false

    private let todoService = TodoService()

    init() {
        Task {
            await fetchNextTodos()
        }
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

    func fetchNextTodos() async {
        guard !isFetching else {
            return
        }
        isFetching = true
        let todos = await todoService.fetchTodos(from: todos.count)
        setTodos(self.todos + todos)
        isFetching = false
    }
}
