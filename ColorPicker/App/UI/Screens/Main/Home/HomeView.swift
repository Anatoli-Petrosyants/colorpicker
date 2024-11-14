//
//  HomeView.swift
//  ColorPicker
//
//  Created by Anatoli Petrosyants on 12.11.24.
//

import SwiftUI
import ComposableArchitecture

// MARK: - HomeView

struct HomeView {
    @Bindable var store: StoreOf<HomeFeature>
}

// MARK: - Views

extension HomeView: View {
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            content
                .defaultNavigationBar()
        } destination: { store in
           switch store.case {
           case let .palettes(store):
               PalettesView(store: store)
           }
       }
    }

    @ViewBuilder private var content: some View {
        ZStack {
            CameraView(centerColor: $store.color)
                .edgesIgnoringSafeArea(.all)

            ZStack {
                Circle()
                    .stroke(Color.white, lineWidth: 1.6)
                    .frame(width: 24, height: 24)
                
                Circle()
                    .stroke(Color.white, lineWidth: 0.8)
                    .frame(width: 10, height: 10)
            }

            VStack(alignment: .center) {
                Spacer()
                
                HStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "photo")
                            .font(.title2)
                    }
                    
                    Spacer()
                    
                    Button {
                        store.send(.view(.onTapColor))
                    } label: {
                        Circle()
                            .fill(Color(uiColor: store.color))
                            .frame(width: 60, height: 60)
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    }
                    .buttonStyle(.plain)
                    
                    Spacer()
                    
                    Button {
                        store.send(.view(.onTapPalettes))
                    } label: {
                        Image(systemName: "circle.hexagonpath.fill")
                            .font(.title2)
                    }
                }
                .tint(.white)
                .padding(.horizontal, 40)
                
                Text(store.currentPalette.name)
                    .font(.body)
                    .bold()
                
                Text(store.currentPalette.hex)
                    .font(.footnote)
                    .foregroundStyle(.gray)
            }
        }
    }
}

#if DEBUG
// MARK: - Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(
            store:
                Store(initialState: HomeFeature.State(), reducer: {
                    HomeFeature()
                })
        )
    }
}
#endif

