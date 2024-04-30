//
//  TodoTableViewController.swift
//  MVVM-iOS
//
//  Created by BYUNGWOOK JEONG on 4/30/24.
//

import UIKit
import Combine

class TodoTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

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
        todoTableViewModel
            .$todos
            .sink { _ in }
            .store(in: &cancellables)
    }

    private func setupViews() {
        view.addSubview(todoTableView)

        // set auto-layout
        NSLayoutConstraint.activate([
            todoTableView.topAnchor.constraint(equalTo: view.topAnchor),
            todoTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            todoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            todoTableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])

        // set data source & delegate
        todoTableView.dataSource = self
        todoTableView.delegate = self
    }

    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return todoTableViewModel.todos.count
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard var cell = tableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell", for: indexPath) as? TodoTableViewCell else {
            return UITableViewCell() // 임시
        }
        cell.todo = todoTableViewModel.todos[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0 // 임시
    }
}
