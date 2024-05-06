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

    weak var delegate: ColorCardDetailViewModelDelegate?

    init(colorCard: ColorCard) {
        self.colorCard = colorCard
    }

    private func setColorCard(_ colorCard: ColorCard) {
        self.colorCard = colorCard
    }

    func changeToRandomColor(id: String) {
        let randomColorCard = ColorCard.getRandomColorCard(id: id)
        delegate?.replaceColorCard(randomColorCard)
        setColorCard(randomColorCard)
    }
}

// MARK: - ColorCardDetailViewModelDelegate

/// Delegate
///   - 다른 ViewModel과의 통신을 위해 사용됩니다.
protocol ColorCardDetailViewModelDelegate: AnyObject {

    func replaceColorCard(_ colorCard: ColorCard)
}
