//
//  ColorCardDetailViewModel.swift
//  MVVM-iOS
//
//  Created by BYUNGWOOK JEONG on 5/3/24.
//

import Foundation

/// ViewModel
///   -  View에 present되기 위한 데이터를 관리하는 역할을 수행합니다. (*business logic은 처리하지 않습니다.*)
final class ColorCardDetailViewModel: ObservableObject {

    @Published private(set) var colorCard: ColorCard

    private let colorCardUseCase = ColorCardUseCase()

    init(colorCard: ColorCard) {
        self.colorCard = colorCard
    }

    private func setColorCard(_ colorCard: ColorCard) {
        self.colorCard = colorCard
    }

    @discardableResult
    func applyRandomColor() -> ColorCard {
        let colorCard = ColorCard.getRandomColorCard(id: colorCard.id)
        setColorCard(colorCard)

        return colorCard
    }
}
