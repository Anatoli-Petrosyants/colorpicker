//
//  CTAButtonStyle.swift
//  ColorPicker
//
//  Created by Anatoli Petrosyants on 12.11.24.
//

import SwiftUI

struct CTAButtonStyle: ButtonStyle {
    
    @Environment(\.isEnabled) private var isEnabled
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.title3)
            .frame(minWidth: 200, maxWidth: .infinity, minHeight: 52)
            .foregroundColor(.white)
            .background(isEnabled ? .black : .gray)
            .clipShape(Capsule())
    }
}

extension ButtonStyle where Self == CTAButtonStyle {
    static var cta: CTAButtonStyle { .init() }
}
