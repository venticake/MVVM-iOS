//
//  ColorCard.swift
//  MVVM-iOS
//
//  Created by BYUNGWOOK JEONG on 4/29/24.
//

import Foundation

struct ColorCard: Identifiable {

    let id: String
    let hexCode: String

    init(id: String = UUID().uuidString, hexCode: String = generateRandomHexColor()) {
        self.id = id
        self.hexCode = hexCode
    }

    private static func generateRandomHexColor() -> String {
        // 랜덤하게 생성된 RGB 값을 저장할 배열 인스턴스 생성
        var randomColorCode = "#"

        for _ in 1...3 {
            let randomByte = Int.random(in: 0...255)
            randomColorCode += String(format: "%02X", randomByte)
        }

        return randomColorCode
    }
}
