//
//  Palette.swift
//  ColorPicker
//
//  Created by Anatoli Petrosyants on 14.11.24.
//

import Foundation
import UIKit
import ColorName

struct Palette: Equatable, Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let hex: String
    let rgb: RGB
}

extension Palette {
    
    static var clear: Palette {
        Palette(name: "", description: "", hex: "", rgb: .init(red: 0, green: 0, blue: 0))
    }
}

struct RGB: Equatable {
    let red: Double
    let green: Double
    let blue: Double
    
    func toString() -> String {
        "\(red), \(green), \(blue)"
    }
}

extension UIColor {
    
    var palette: Palette {
        .init(
            name: getName(for: self),
            description: "",
            hex: self.toHex(),
            rgb: .init(
                red: Double(self.cgColor.components![0]),
                green: Double(self.cgColor.components![1]),
                blue: Double(self.cgColor.components![2])
            )
        )
    }
}
