//
//  UIColor+Extensions.swift
//  ColorPicker
//
//  Created by Anatoli Petrosyants on 14.11.24.
//

import Foundation

extension UIColor {
    func toHex() -> String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            assertionFailure("Failed to get RGBA components from UIColor")
            return "#000000"
        }

        // Clamp components to [0.0, 1.0]
        red = max(0, min(1, red))
        green = max(0, min(1, green))
        blue = max(0, min(1, blue))
        alpha = max(0, min(1, alpha))

        if alpha == 1 {
            // RGB
            return String(
                format: "#%02lX%02lX%02lX",
                Int(round(red * 255)),
                Int(round(green * 255)),
                Int(round(blue * 255))
            )
        } else {
            // RGBA
            return String(
                format: "#%02lX%02lX%02lX%02lX",
                Int(round(red * 255)),
                Int(round(green * 255)),
                Int(round(blue * 255)),
                Int(round(alpha * 255))
            )
        }
    }
}

extension UIColor {
    
    /// Returns the RGB and alpha components of the UIColor as a tuple.
    var rgbValues: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        let success = self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        // Only return the values if the color components were successfully retrieved
        return success ? (red, green, blue, alpha) : nil
    }
}

import UIKit

extension UIColor {
    static let extendedColorNames: [String: UIColor] = [
        "amber": UIColor(red: 1.0, green: 0.75, blue: 0.0, alpha: 1.0),
        "aqua": UIColor(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0),
        "aquamarine": UIColor(red: 0.5, green: 1.0, blue: 0.83, alpha: 1.0),
        "azure": UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0),
        "beige": UIColor(red: 0.96, green: 0.96, blue: 0.86, alpha: 1.0),
        "bisque": UIColor(red: 1.0, green: 0.89, blue: 0.77, alpha: 1.0),
        "black": .black,
        "blush": UIColor(red: 0.87, green: 0.36, blue: 0.51, alpha: 1.0),
        "blue": .blue,
        "brick": UIColor(red: 0.8, green: 0.25, blue: 0.33, alpha: 1.0),
        "bronze": UIColor(red: 0.8, green: 0.5, blue: 0.2, alpha: 1.0),
        "brown": .brown,
        "burgundy": UIColor(red: 0.5, green: 0.0, blue: 0.13, alpha: 1.0),
        "chartreuse": UIColor(red: 0.5, green: 1.0, blue: 0.0, alpha: 1.0),
        "chocolate": UIColor(red: 0.82, green: 0.41, blue: 0.12, alpha: 1.0),
        "coral": UIColor(red: 1.0, green: 0.5, blue: 0.31, alpha: 1.0),
        "cream": UIColor(red: 1.0, green: 0.99, blue: 0.82, alpha: 1.0),
        "crimson": UIColor(red: 0.86, green: 0.08, blue: 0.24, alpha: 1.0),
        "cyan": .cyan,
        "darkGray": .darkGray,
        "dodgerBlue": UIColor(red: 0.12, green: 0.56, blue: 1.0, alpha: 1.0),
        "emerald": UIColor(red: 0.31, green: 0.78, blue: 0.47, alpha: 1.0),
        "firebrick": UIColor(red: 0.7, green: 0.13, blue: 0.13, alpha: 1.0),
        "forestGreen": UIColor(red: 0.13, green: 0.55, blue: 0.13, alpha: 1.0),
        "fuchsia": UIColor(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0),
        "ginger": UIColor(red: 0.8, green: 0.55, blue: 0.3, alpha: 1.0),
        "gold": UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 1.0),
        "goldenrod": UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.0),
        "gray": .gray,
        "green": .green,
        "indigo": UIColor(red: 0.29, green: 0.0, blue: 0.51, alpha: 1.0),
        "ivory": UIColor(red: 1.0, green: 1.0, blue: 0.94, alpha: 1.0),
        "jade": UIColor(red: 0.0, green: 0.66, blue: 0.42, alpha: 1.0),
        "khaki": UIColor(red: 0.76, green: 0.69, blue: 0.57, alpha: 1.0),
        "lavender": UIColor(red: 0.9, green: 0.9, blue: 0.98, alpha: 1.0),
        "lavenderBlush": UIColor(red: 1.0, green: 0.94, blue: 0.96, alpha: 1.0),
        "lightCoral": UIColor(red: 0.94, green: 0.5, blue: 0.5, alpha: 1.0),
        "lightGray": .lightGray,
        "lime": UIColor(red: 0.75, green: 1.0, blue: 0.0, alpha: 1.0),
        "lilac": UIColor(red: 0.78, green: 0.64, blue: 0.78, alpha: 1.0),
        "magenta": .magenta,
        "mahogany": UIColor(red: 0.75, green: 0.25, blue: 0.0, alpha: 1.0),
        "maroon": UIColor(red: 0.5, green: 0.0, blue: 0.0, alpha: 1.0),
        "mint": UIColor(red: 0.6, green: 1.0, blue: 0.6, alpha: 1.0),
        "mustard": UIColor(red: 1.0, green: 0.86, blue: 0.35, alpha: 1.0),
        "navy": UIColor(red: 0.0, green: 0.0, blue: 0.5, alpha: 1.0),
        "ochre": UIColor(red: 0.8, green: 0.47, blue: 0.13, alpha: 1.0),
        "olive": UIColor(red: 0.5, green: 0.5, blue: 0.0, alpha: 1.0),
        "orange": .orange,
        "orchid": UIColor(red: 0.85, green: 0.44, blue: 0.84, alpha: 1.0),
        "peach": UIColor(red: 1.0, green: 0.85, blue: 0.73, alpha: 1.0),
        "periwinkle": UIColor(red: 0.8, green: 0.8, blue: 1.0, alpha: 1.0),
        "pink": UIColor(red: 1.0, green: 0.75, blue: 0.8, alpha: 1.0),
        "plum": UIColor(red: 0.56, green: 0.27, blue: 0.52, alpha: 1.0),
        "purple": .purple,
        "red": .red,
        "rose": UIColor(red: 1.0, green: 0.75, blue: 0.8, alpha: 1.0),
        "royalBlue": UIColor(red: 0.25, green: 0.41, blue: 0.88, alpha: 1.0),
        "rust": UIColor(red: 0.72, green: 0.26, blue: 0.0, alpha: 1.0),
        "salmon": UIColor(red: 0.98, green: 0.5, blue: 0.45, alpha: 1.0),
        "sand": UIColor(red: 0.76, green: 0.7, blue: 0.5, alpha: 1.0),
        "sepia": UIColor(red: 0.44, green: 0.26, blue: 0.08, alpha: 1.0),
        "skyBlue": UIColor(red: 0.53, green: 0.81, blue: 0.92, alpha: 1.0),
        "slateGray": UIColor(red: 0.44, green: 0.5, blue: 0.56, alpha: 1.0),
        "steelBlue": UIColor(red: 0.27, green: 0.51, blue: 0.71, alpha: 1.0),
        "tan": UIColor(red: 0.82, green: 0.71, blue: 0.55, alpha: 1.0),
        "teal": UIColor(red: 0.0, green: 0.5, blue: 0.5, alpha: 1.0),
        "tomato": UIColor(red: 1.0, green: 0.39, blue: 0.28, alpha: 1.0),
        "turquoise": UIColor(red: 0.25, green: 0.88, blue: 0.82, alpha: 1.0),
        "violet": UIColor(red: 0.93, green: 0.51, blue: 0.93, alpha: 1.0),
        "wheat": UIColor(red: 0.96, green: 0.87, blue: 0.7, alpha: 1.0),
        "white": .white,
        "yellow": .yellow,
        "yellowGreen": UIColor(red: 0.6, green: 0.8, blue: 0.2, alpha: 1.0)
    ]
    
    // Function to get the closest color name for a given UIColor
    func colorName() -> String? {
        var closestName: String?
        var smallestDistance: CGFloat = CGFloat.greatestFiniteMagnitude
        
        for (name, color) in UIColor.extendedColorNames {
            let distance = colorDistance(to: color)
            if distance < smallestDistance {
                smallestDistance = distance
                closestName = name
            }
        }
        
        return closestName
    }
    
    // Helper function to calculate color distance
    private func colorDistance(to color: UIColor) -> CGFloat {
        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0
        
        self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        let redDiff = r1 - r2
        let greenDiff = g1 - g2
        let blueDiff = b1 - b2
        
        return sqrt(redDiff * redDiff + greenDiff * greenDiff + blueDiff * blueDiff)
    }
}
