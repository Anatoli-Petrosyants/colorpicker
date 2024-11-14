//
//  PalettesView.swift
//  ColorPicker
//
//  Created by Anatoli Petrosyants on 14.11.24.
//

import SwiftUI
import ComposableArchitecture

// MARK: - PalettesView

struct PalettesView {
    let store: StoreOf<PalettesFeature>
}

// MARK: - Views

extension PalettesView: View {
    var body: some View {
        content
            .onAppear {
                store.send(.view(.onAppear))
            }
    }
    
    @ViewBuilder
    private var content: some View {
        Text("All Color")// , store.count
    }
}
