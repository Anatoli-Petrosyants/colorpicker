//
//  MainFeature.swift
//  ColorPicker
//
//  Created by Anatoli Petrosyants on 12.11.24.
//

import SwiftUI
import ComposableArchitecture
import ColorName

@Reducer
struct MainFeature {
    
    @ObservableState
    struct State {
        var color = UIColor.clear
        var colorName = ""
        var colorHex = ""
    }
    
    enum Action: BindableAction {
        case onTapColor
        case binding(BindingAction<State>)
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
                
            case .onTapColor:
                return .none
            
            case .binding(\.color):
                let name = getName(for: state.color)
                if state.colorName != name {
                    state.colorName = name
                }
                
                state.colorHex = state.color.toHex()
                
                return .none
                
            case .binding:
                return .none
            }
        }
    }
}

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
