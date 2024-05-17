//
//  Color+.swift
//  Soongan
//
//  Created by jun on 5/15/24.
//

import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }
}

extension Color {

    // MARK: - Core

    static let primaryA = Color(hex: 0x252525)
    static let primaryB = Color(hex: 0xF5F5F5)
    static let accent = Color(hex: 0xFBC304)
    static let positive = Color(hex: 0x276EF1)
    static let negative = Color(hex: 0xDE1135)

    // MARK: - Grayscale

    static let gray100 = Color(hex: 0xDBDBDB)
    static let gray200 = Color(hex: 0xC1C1C1)
    static let gray300 = Color(hex: 0xA7A7A7)
    static let gray400 = Color(hex: 0x8D8D8D)
    static let gray500 = Color(hex: 0x737373)
    static let gray600 = Color(hex: 0x595959)
    static let gray700 = Color(hex: 0x3F3F3F)
}
