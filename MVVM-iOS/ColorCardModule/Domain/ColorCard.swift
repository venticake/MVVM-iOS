//
//  ColorCard.swift
//  MVVM-iOS
//
//  Created by BYUNGWOOK JEONG on 4/29/24.
//

import Foundation

/// Domain model
struct ColorCard: Identifiable {

    let id: String
    let red: Float
    let green: Float
    let blue: Float
    let alpha: Float

    var redCGFloat: CGFloat {
        return CGFloat(red)
    }
    var greenCGFloat: CGFloat {
        return CGFloat(green)
    }
    var blueCGFloat: CGFloat {
        return CGFloat(blue)
    }
    var alphaCGFloat: CGFloat {
        return CGFloat(alpha)
    }
    var hexCode: String {
        let redHex = changeToHex(floatValue: red)
        let greenHex = changeToHex(floatValue: green)
        let blueHex = changeToHex(floatValue: blue)
        let alphaHex = changeToHex(floatValue: alpha)

        return "#\(redHex)\(greenHex)\(blueHex)\(alphaHex)"
    }

    init(id: String = UUID().uuidString, red: Float, green: Float, blue: Float, alpha: Float) {
        self.id = id
        self.red = Self.applyUnitRange(value: red)
        self.green = Self.applyUnitRange(value: green)
        self.blue = Self.applyUnitRange(value: blue)
        self.alpha = Self.applyUnitRange(value: alpha)
    }

    static private func applyUnitRange(value: Float) -> Float {
        if value < 0.0 { return 0.0 }
        if value > 1.0 { return 1.0 }

        return value
    }

    static func getRandomColorCard(id: String = UUID().uuidString, alpha: Float = 1.0) -> Self {
        return .init(
            id: id,
            red: Float.random(in: 0.0..<1.0),
            green: Float.random(in: 0.0..<1.0),
            blue: Float.random(in: 0.0..<1.0),
            alpha: alpha
        )
    }

    private func changeToHex(floatValue: Float) -> String {
        let intValue = Int(floatValue * 255.0)

        return String(format: "%02X", intValue)
    }
}
