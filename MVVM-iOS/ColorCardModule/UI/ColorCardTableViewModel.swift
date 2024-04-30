//
//  ColorCardTableViewModel.swift
//  MVVM-iOS
//
//  Created by BYUNGWOOK JEONG on 4/30/24.
//

import Foundation

@MainActor
final class ColorCardTableViewModel: ObservableObject {

    @Published private(set) var colorCards: [ColorCard] = []

    private let colorCardService = ColorCardService()
    private var isFetching = false

    init() {
        Task {
            await fetchNextColorCards()
        }
    }

    private func setColorCards(_ colorCards: [ColorCard]) {
        self.colorCards = colorCards
    }

    func removeColorCard(id: String) {
        colorCards = colorCardService.removeColorCard(id: id, from: colorCards)
        setColorCards(colorCards)
    }

    func fetchNextColorCards() async {
        guard !isFetching else {
            return
        }
        isFetching = true
        let colorCards = await colorCardService.fetchColorCards(from: colorCards.count)
        setColorCards(self.colorCards + colorCards)
        isFetching = false
    }
}
