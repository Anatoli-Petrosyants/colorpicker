//
//  PaletteItemView.swift
//  ColorPicker
//
//  Created by Anatoli Petrosyants on 14.11.24.
//

import SwiftUI
import ComposableArchitecture

// MARK: - ProductItemView

struct PaletteItemView {
    let store: StoreOf<PaletteItemFeature>
}

// MARK: - Views

extension PaletteItemView: View {
    
    var body: some View {
        content
            .onTapGesture { self.store.send(.view(.onItemTap)) }
            .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder private var content: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("PaletteItemView")
        }
        .background(.red)
        .padding()
    }
}
