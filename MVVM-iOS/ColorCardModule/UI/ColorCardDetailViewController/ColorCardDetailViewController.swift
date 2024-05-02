//
//  ColorCardDetailViewController.swift
//  MVVM-iOS
//
//  Created by BYUNGWOOK JEONG on 5/2/24.
//

import UIKit
import Combine

final class ColorCardDetailViewController: UIViewController {

    let colorCardDetailView: ColorCardDetailView = {
        let view = ColorCardDetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var colorCardViewModel: ColorCardViewModel?
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        setupViews()
        colorCardViewModel?.$selectedColorCard
            .receive(on: DispatchQueue.main)
            .sink { [weak self] colorCard in
                self?.configureNavigationTitle(title: colorCard?.hexCode)
                self?.colorCardDetailView.colorCard = colorCard
            }
            .store(in: &cancellables)
    }

    private func configureNavigationTitle(title: String?) {
        self.title = title
    }

    private func configureNavigation() {
        configureNavigationTitle(title: colorCardViewModel?.selectedColorCard?.hexCode)
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
        guard let selectedColorCard = colorCardViewModel?.selectedColorCard else {
            return
        }
        colorCardViewModel?.changeToRandomColor(id: selectedColorCard.id)
    }
}
