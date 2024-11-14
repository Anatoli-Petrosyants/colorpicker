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

struct RGB: Equatable {
    let red: Double
    let green: Double
    let blue: Double
    
    func toString() -> String {
        "\(red), \(green), \(blue)"
    }
}

extension Palette {
    
    static var clear: Palette {
        Palette(name: "", description: "", hex: "", rgb: .init(red: 0, green: 0, blue: 0))
    }
}

extension Palette {
    
    static var mock: [Palette] {
        [
            Palette(name: "Crimson Red",
                    description: "A strong, deep red color",
                    hex: "#DC143C",
                    rgb: RGB(red: 220, green: 20, blue: 60)),
            Palette(name: "Royal Blue",
                    description: "A rich, dark blue",
                    hex: "#4169E1",
                    rgb: RGB(red: 65, green: 105, blue: 225)),
            Palette(name: "Forest Green",
                    description: "A medium green color",
                    hex: "#228B22", rgb: RGB(red: 34, green: 139, blue: 34)),
            Palette(name: "Goldenrod",
                    description: "A warm, yellowish-gold color",
                    hex: "#DAA520",
                    rgb: RGB(red: 218, green: 165, blue: 32)),
            Palette(name: "Magenta",
                    description: "A vivid purplish-red color",
                    hex: "#FF00FF",
                    rgb: RGB(red: 255, green: 0, blue: 255)),
            Palette(name: "Slate Gray",
                    description: "A cool, muted gray color",
                    hex: "#708090",
                    rgb: RGB(red: 112, green: 128, blue: 144)),
            Palette(name: "Teal",
                    description: "A dark cyan-green color",
                    hex: "#008080",
                    rgb: RGB(red: 0, green: 128, blue: 128)),
            Palette(name: "Lavender Blush",
                    description: "A pale, pinkish color",
                    hex: "#FFF0F5",
                    rgb: RGB(red: 255, green: 240, blue: 245)),
            Palette(name: "Coral",
                    description: "A pink-orange color",
                    hex: "#FF7F50",
                    rgb: RGB(red: 255, green: 127, blue: 80)),
            Palette(name: "Mint",
                    description: "A soft, light green",
                    hex: "#98FF98",
                    rgb: RGB(red: 152, green: 255, blue: 152)),
        ]
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
