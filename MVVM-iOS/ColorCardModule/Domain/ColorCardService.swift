//
//  ColorCardService.swift
//  MVVM-iOS
//
//  Created by BYUNGWOOK JEONG on 4/30/24.
//

import Foundation

struct ColorCardService {

    private let colorCardRepository = ColorCardRepository()

    func fetchColorCards(from: Int = 0, count: Int = 10) async -> [ColorCard] {
        return await colorCardRepository.fetchColorCards(from: from, count: count)
    }

    func removeColorCard(id: String, from colorCards: [ColorCard]) -> [ColorCard] {
        return colorCards.filter { $0.id != id }
    }
}
