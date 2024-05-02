//
//  ColorCardTableViewCell.swift
//  MVVM-iOS
//
//  Created by BYUNGWOOK JEONG on 4/30/24.
//

import UIKit

/// View
///   - 전달받은 데이터를 화면에 present합니다.
final class ColorCardTableViewCell: UITableViewCell {

    var colorCard: ColorCard? {
        didSet {
            titleLabel.text = colorCard?.hexCode
            titleLabel.backgroundColor = .getUIColor(from: colorCard)
        }
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0)
        ])

        let constraint = titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0)
        constraint.priority = UILayoutPriority(999)
        constraint.isActive = true
    }
}
