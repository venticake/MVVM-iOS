//
//  ColorCard+UIColor.swift
//  MVVM-iOS
//
//  Created by BYUNGWOOK JEONG on 5/2/24.
//

import Foundation
import UIKit

extension UIColor {

    static func getUIColor(from colorCard: ColorCard?) -> UIColor? {
        guard let colorCard else {
            return nil
        }

        return UIColor(red: colorCard.redCGFloat, green: colorCard.greenCGFloat, blue: colorCard.blueCGFloat, alpha: colorCard.alphaCGFloat)
    }
}
