//
//  ColorCardDetailViewController.swift
//  MVVM-iOS
//
//  Created by BYUNGWOOK JEONG on 5/2/24.
//

import UIKit

final class ColorCardDetailViewController: UIViewController {

    let colorCardDetailView: ColorCardDetailView = {
        let view = ColorCardDetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        setupViews()
    }

    private func configureNavigation() {
        title = colorCardDetailView.colorCard?.hexCode
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
}
