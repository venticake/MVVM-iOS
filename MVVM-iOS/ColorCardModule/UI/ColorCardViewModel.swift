//
//  ColorCardViewModel.swift
//  MVVM-iOS
//
//  Created by BYUNGWOOK JEONG on 4/30/24.
//

import Foundation

/// ViewModel
///   -  View에 present되기 위한 데이터를 관리하는 역할을 수행합니다. (*business logic은 처리하지 않습니다.*)

final class ColorCardViewModel: ObservableObject {

    @Published private(set) var colorCards: [ColorCard] = []
    @Published private(set) var selectedColorCard: ColorCard?

    private let colorCardUseCase = ColorCardUseCase()
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
        colorCards = colorCardUseCase.removeColorCard(id: id, from: colorCards)
        setColorCards(colorCards)
    }

    func changeToRandomColor(id: String) {
        let (newColorCard, newColorCards) = colorCardUseCase.changeToRandomColor(id: id, from: colorCards)
        setColorCards(newColorCards)
        selectColorCard(newColorCard)
    }

    func fetchNextColorCards() async {
        guard !isFetching else {
            return
        }
        isFetching = true
        let colorCards = await colorCardUseCase.fetchColorCards(from: colorCards.count)
        setColorCards(self.colorCards + colorCards)
        isFetching = false
    }
}
