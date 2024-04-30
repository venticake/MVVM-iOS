//
//  ColorCard.swift
//  MVVM-iOS
//
//  Created by BYUNGWOOK JEONG on 4/29/24.
//

import Foundation

struct ColorCard: Identifiable {

    let id: String
    let title: String
    let content: String

    init(id: String = UUID().uuidString, title: String, content: String) {
        self.id = id
        self.title = title
        self.content = content
    }
}
