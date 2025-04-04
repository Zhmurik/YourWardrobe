//
//  UIColor+Extension.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 2/1/25.
//
import UIKit

extension UIColor {
    static func hex(rgbValue: UInt64) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: 1.0
        )
    }
}
