//
//  ColorCardUseCase.swift
//  MVVM-iOS
//
//  Created by BYUNGWOOK JEONG on 4/30/24.
//

import Foundation

/// UseCase
///   - business logic을 담당하고 있습니다.
struct ColorCardUseCase {

    private let colorCardRepository = ColorCardRepository()

    func fetchColorCards(from: Int = 0, count: Int = 30) async -> [ColorCard] {
        return await colorCardRepository.fetchColorCards(from: from, count: count)
    }

    func removeColorCard(id: String, from oldColorCards: [ColorCard]) -> [ColorCard] {
        let newColorCards = oldColorCards.filter { $0.id != id }

        return newColorCards
    }

    func changeColorCard(id: String, to newColorCard: ColorCard, from oldColorCards: [ColorCard]) -> [ColorCard] {
        let newColorCards = oldColorCards.map { $0.id == id ? newColorCard : $0 }

        return newColorCards
    }
}
