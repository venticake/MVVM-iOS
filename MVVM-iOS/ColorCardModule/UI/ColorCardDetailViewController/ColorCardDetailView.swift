//
//  ColorCardDetailView.swift
//  MVVM-iOS
//
//  Created by BYUNGWOOK JEONG on 5/2/24.
//

import UIKit

final class ColorCardDetailView: UIView {

    var colorCard: ColorCard? {
        didSet {
            colorView.backgroundColor = .getUIColor(from: colorCard)
        }
    }

    private let colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(colorView)

        NSLayoutConstraint.activate([
            colorView.topAnchor.constraint(equalTo: topAnchor, constant: 0.0),
            colorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0.0),
            colorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0.0),
            colorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0.0)
        ])
    }
}
