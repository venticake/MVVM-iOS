//
//  ColorCardTableViewModel.swift
//  MVVM-iOS
//
//  Created by BYUNGWOOK JEONG on 5/3/24.
//

import Foundation

/// ViewModel
///   -  View에 present되기 위한 데이터를 관리하는 역할을 수행합니다. (*business logic은 처리하지 않습니다.*)
final class ColorCardTableViewModel: ObservableObject, ColorCardDetailViewModelDelegate {

    @Published private(set) var colorCards: [ColorCard] = []

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

    func removeColorCard(id: String) {
        colorCards = colorCardUseCase.removeColorCard(id: id, from: colorCards)
        setColorCards(colorCards)
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

    // MARK: - ColorCardDetailViewModelDelegate

    func replaceColorCard(_ colorCard: ColorCard) {
        let colorCards = colorCardUseCase.replaceColorCard(id: colorCard.id, to: colorCard, from: colorCards)
        setColorCards(colorCards)
    }
}
