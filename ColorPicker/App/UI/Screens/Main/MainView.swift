//
//  MainView.swift
//  ColorPicker
//
//  Created by Anatoli Petrosyants on 12.11.24.
//

import SwiftUI
import ComposableArchitecture

// MARK: - MainView

struct MainView {
    @Bindable var store: StoreOf<MainFeature>

    var body: some View {
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
                
                Button {
                    store.send(.onTapColor)
                } label: {
                    Circle()
                        .fill(Color(uiColor: store.color))
                        .frame(width: 60, height: 60)
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                }
                .buttonStyle(.plain)
                
                Text(store.colorName)
                    .font(.body)
                    .bold()
                
                Text(store.colorHex)
                    .font(.footnote)
                    .foregroundStyle(.gray)
            }
        }
    }
}

// MARK: - Views

extension MainView: View {
    
    
}

#if DEBUG
// MARK: - Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(
            store:
                Store(initialState: MainFeature.State(), reducer: {
                    MainFeature()
                })
        )
    }
}
#endif

