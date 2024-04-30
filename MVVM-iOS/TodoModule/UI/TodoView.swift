//
//  TodoView.swift
//  MVVM-iOS
//
//  Created by BYUNGWOOK JEONG on 4/29/24.
//

import UIKit

class TodoView: UIView {

    var todo: Todo? {
        didSet {
            titleLabel.text = todo?.title
            contentView.text = todo?.content
        }
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = .yellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let contentView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.backgroundColor = .green
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .blue
        addSubview(titleLabel)
        addSubview(contentView)

        // set auto-layout
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20.0),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0),
            contentView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20.0),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0),
            contentView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20.0)
        ])
    }
}
