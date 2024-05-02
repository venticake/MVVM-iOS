//
//  ColorCardTableViewController.swift
//  MVVM-iOS
//
//  Created by BYUNGWOOK JEONG on 4/30/24.
//

import UIKit
import Combine

final class ColorCardTableViewController:
    UIViewController,
    UITableViewDataSource,
    UITableViewDelegate,
    UITableViewDataSourcePrefetching
{
    private let colorCardTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(ColorCardTableViewCell.self, forCellReuseIdentifier: "ColorCardTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let colorCardViewModel = ColorCardViewModel()
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        setupViews()
        colorCardViewModel.$colorCards
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
        return colorCardViewModel.colorCards.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ColorCardTableViewCell", for: indexPath) as! ColorCardTableViewCell
        cell.colorCard = colorCardViewModel.colorCards[indexPath.row]
        cell.selectionStyle = .none

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let colorCardId = colorCardViewModel.colorCards[indexPath.row].id
            colorCardViewModel.removeColorCard(id: colorCardId)
            colorCardTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let colorCard = colorCardViewModel.colorCards[indexPath.row]
        let nextViewController = ColorCardDetailViewController()
        nextViewController.colorCardViewModel = colorCardViewModel
        nextViewController.colorCardViewModel?.selectColorCard(colorCard)
        navigationController?.pushViewController(nextViewController, animated: true)
    }

    // MARK: - UITableViewDataSourcePrefetching

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxIndexPath = indexPaths.max(by: { $0.row < $1.row }),
              maxIndexPath.row >= colorCardViewModel.colorCards.count - 1 else {
            return
        }

        Task {
            await colorCardViewModel.fetchNextColorCards()
        }
    }
}
