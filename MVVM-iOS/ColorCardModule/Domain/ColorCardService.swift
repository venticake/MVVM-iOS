//
//  ColorCardService.swift
//  MVVM-iOS
//
//  Created by BYUNGWOOK JEONG on 4/30/24.
//

import Foundation

struct ColorCardService {

    private let colorCardRepository = ColorCardRepository()

    func fetchColorCards(from: Int = 0, count: Int = 30) async -> [ColorCard] {
        return await colorCardRepository.fetchColorCards(from: from, count: count)
    }

    func removeColorCard(id: String, from oldColorCards: [ColorCard]) -> [ColorCard] {
        let newColorCards = oldColorCards.filter { $0.id != id }

        return newColorCards
    }

    func changeToRandomColor(id: String, from oldColorCards: [ColorCard]) -> (newColorCard: ColorCard, newColorCards: [ColorCard]) {
        let newColorCard = ColorCard.getRandomColorCard(id: id)
        let newColorCards = oldColorCards.map { $0.id == id ? newColorCard : $0 }

        return (newColorCard, newColorCards)
    }
}
