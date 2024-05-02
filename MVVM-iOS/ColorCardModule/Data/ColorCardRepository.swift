//
//  ColorCardRepository.swift
//  MVVM-iOS
//
//  Created by BYUNGWOOK JEONG on 4/30/24.
//

import Foundation

/// Repository
///   - Entity를 Domain model로 mapping하는 역할을 수행합니다.
struct ColorCardRepository {

    func fetchColorCards(from: Int, count: Int) async -> [ColorCard] {
        // 네트워크 통신을 통해, 서버로부터 데이터를 받아온 상황을 가정
        try? await Task.sleep(nanoseconds: 1_000_000_000) // 1.0 s

        return (0..<count).map { _ in ColorCard.getRandomColorCard() }
    }
}
