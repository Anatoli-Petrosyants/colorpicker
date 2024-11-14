//
//  PalettesView.swift
//  ColorPicker
//
//  Created by Anatoli Petrosyants on 14.11.24.
//

import SwiftUI
import ComposableArchitecture

// MARK: - PalettesView

struct PalettesView: View {
    @Bindable var store: StoreOf<HomeFeature>

    var body: some View {
        VStack {
            Text("Palettes", store.count)
        }
        .onAppear {
            store.send(.view(.onAppear))
        }
    }
}

#if DEBUG
// MARK: - Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PalettesView(
            store:
                Store(initialState: HomeFeature.State(), reducer: {
                    HomeFeature()
                })
        )
    }
}
#endif
