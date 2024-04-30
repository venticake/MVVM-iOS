//
//  TodoTableViewController.swift
//  MVVM-iOS
//
//  Created by BYUNGWOOK JEONG on 4/30/24.
//

import UIKit
import Combine

final class TodoTableViewController:
    UIViewController,
    UITableViewDataSource,
    UITableViewDelegate,
    UITableViewDataSourcePrefetching
{
    private let todoTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: "TodoTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private var todoTableViewModel = TodoTableViewModel()
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        todoTableViewModel.$todos
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.todoTableView.reloadData()
            }
            .store(in: &cancellables)
    }

    private func setupViews() {
        view.addSubview(todoTableView)

        // set data source & delegate
        todoTableView.dataSource = self
        todoTableView.delegate = self
        todoTableView.prefetchDataSource = self

        // set auto-layout
        NSLayoutConstraint.activate([
            todoTableView.topAnchor.constraint(equalTo: view.topAnchor),
            todoTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            todoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            todoTableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoTableViewModel.todos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell", for: indexPath) as! TodoTableViewCell
        cell.todo = todoTableViewModel.todos[indexPath.row]
        cell.selectionStyle = .none

        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

    // MARK: - UITableViewDataSourcePrefetching

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxIndexPath = indexPaths.max(by: { $0.row < $1.row }),
              maxIndexPath.row >= todoTableViewModel.todos.count - 1 else {
            return
        }

        Task {
            await todoTableViewModel.fetchNextTodos()
        }
    }
}
