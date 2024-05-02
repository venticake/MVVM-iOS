//
//  ColorCardViewModel.swift
//  MVVM-iOS
//
//  Created by BYUNGWOOK JEONG on 4/30/24.
//

import Foundation

@MainActor
final class ColorCardViewModel: ObservableObject {

    @Published private(set) var colorCards: [ColorCard] = []
    @Published private(set) var selectedColorCard: ColorCard?

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

    func selectColorCard(_ colorCard: ColorCard) {
        selectedColorCard = colorCard
    }

    func deselectColorCard() {
        selectedColorCard = nil
    }

    func removeColorCard(id: String) {
        colorCards = colorCardService.removeColorCard(id: id, from: colorCards)
        setColorCards(colorCards)
    }

    func changeToRandomColor(id: String) {
        let newColorCard = ColorCard.getRandomColorCard(id: id)
        let oldColorCards = colorCards
        let newColorCards = oldColorCards.map { $0.id == id ? newColorCard : $0 }
        setColorCards(newColorCards)
        selectColorCard(newColorCard)
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
