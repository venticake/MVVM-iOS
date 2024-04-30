//
//  ColorCardRepository.swift
//  MVVM-iOS
//
//  Created by BYUNGWOOK JEONG on 4/30/24.
//

import Foundation

/// entity -> model
struct ColorCardRepository {

    func fetchColorCards(from: Int = 0, count: Int = 10) async -> [ColorCard] {
        try? await Task.sleep(nanoseconds: 1_000_000_000) // 1.0 s

        return (0..<count).map { _ in ColorCard() }
    }
}
