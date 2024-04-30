//
//  ColorCardRepository.swift
//  MVVM-iOS
//
//  Created by BYUNGWOOK JEONG on 4/30/24.
//

import Foundation

/// entity -> model
struct ColorCardRepository {

    func fetchColorCards(from: Int = 0, count: Int = 10) async -> [ColorCard] {
        var colorCards = [ColorCard]()

        for index in from..<from + count {
            let colorCard = ColorCard(title: "temp title \(index)", content: "temp content")
            colorCards.append(colorCard)
        }

        try? await Task.sleep(nanoseconds: 1_000_000_000) // 1.0 s

        return colorCards
    }
}
