//
//  ColorCardTableViewController.swift
//  MVVM-iOS
//
//  Created by BYUNGWOOK JEONG on 4/30/24.
//

import UIKit
import Combine

/// View (ViewController)
///   - ViewModel을 binding함으로써, ui를 업데이트하는 역할을 수행합니다.
final class ColorCardTableViewController:
    UIViewController,
    UITableViewDataSource,
    UITableViewDelegate,
    UITableViewDataSourcePrefetching
{
    private let colorCardTableViewModel = ColorCardTableViewModel()
    private var cancellables: Set<AnyCancellable> = []

    private let colorCardTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(ColorCardTableViewCell.self, forCellReuseIdentifier: "ColorCardTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        setupViews()
        colorCardTableViewModel.$colorCards
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.colorCardTableView.reloadData()
            }
            .store(in: &cancellables)
    }

    private func configureNavigation() {
        title = "Colors"
    }

    private func setupViews() {
        view.addSubview(colorCardTableView)

        // set data source & delegate
        colorCardTableView.dataSource = self
        colorCardTableView.delegate = self
        colorCardTableView.prefetchDataSource = self

        // set auto-layout
        NSLayoutConstraint.activate([
            colorCardTableView.topAnchor.constraint(equalTo: view.topAnchor),
            colorCardTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            colorCardTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            colorCardTableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorCardTableViewModel.colorCards.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ColorCardTableViewCell", for: indexPath) as! ColorCardTableViewCell
        cell.colorCard = colorCardTableViewModel.colorCards[indexPath.row]
        cell.selectionStyle = .none

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let colorCardId = colorCardTableViewModel.colorCards[indexPath.row].id
            colorCardTableViewModel.removeColorCard(id: colorCardId)
            colorCardTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let colorCard = colorCardTableViewModel.colorCards[indexPath.row]
        let nextViewController = ColorCardDetailViewController(colorCard: colorCard)
        nextViewController.colorCardDetailViewModel.delegate = colorCardTableViewModel
        navigationController?.pushViewController(nextViewController, animated: true)
    }

    // MARK: - UITableViewDataSourcePrefetching

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxIndexPath = indexPaths.max(by: { $0.row < $1.row }),
              maxIndexPath.row >= colorCardTableViewModel.colorCards.count - 1 else {
            return
        }

        Task {
            await colorCardTableViewModel.fetchNextColorCards()
        }
    }
}
