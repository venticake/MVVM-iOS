//
//  ColorCardDetailViewController.swift
//  MVVM-iOS
//
//  Created by BYUNGWOOK JEONG on 5/2/24.
//

import UIKit
import Combine

/// View (ViewController)
///   - ViewModel을 binding함으로써, ui를 업데이트하는 역할을 수행합니다.
final class ColorCardDetailViewController: UIViewController {

    weak var delegate: ColorCardDetailViewControllerDelegate?

    let colorCardDetailViewModel: ColorCardDetailViewModel
    private var cancellables: Set<AnyCancellable> = []

    private let colorCardDetailView: ColorCardDetailView = {
        let view = ColorCardDetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init(colorCard: ColorCard) {
        colorCardDetailViewModel = .init(colorCard: colorCard)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        setupViews()
        colorCardDetailViewModel.$colorCard
            .receive(on: DispatchQueue.main)
            .sink { [weak self] colorCard in
                self?.configureNavigationTitle(title: colorCard.hexCode)
                self?.colorCardDetailView.colorCard = colorCard
            }
            .store(in: &cancellables)
    }

    private func configureNavigationTitle(title: String?) {
        self.title = title
    }

    private func configureNavigation() {
        configureNavigationTitle(title: colorCardDetailViewModel.colorCard.hexCode)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .plain, target: self, action: #selector(onClickChangeColorButton))
    }

    private func setupViews() {
        view.addSubview(colorCardDetailView)

        NSLayoutConstraint.activate([
            colorCardDetailView.topAnchor.constraint(equalTo: view.topAnchor),
            colorCardDetailView.leftAnchor.constraint(equalTo: view.leftAnchor),
            colorCardDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            colorCardDetailView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

    @objc func onClickChangeColorButton() {
        let colorCard = colorCardDetailViewModel.applyRandomColor()
        delegate?.replaceColorCard(colorCard)
    }
}

// MARK: - ColorCardDetailViewControllerDelegate

/// Delegate
///   - 다른 ViewController와의 통신을 위해 사용됩니다.
protocol ColorCardDetailViewControllerDelegate: AnyObject {

    func replaceColorCard(_ colorCard: ColorCard)
}
