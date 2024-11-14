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
              // state.colorName = state.color.colorName().valueOr("")
              state.colorName = getName(for: state.color)
              state.colorHex = state.color.toHex()
              return .none

          case .binding:
              return .none
          }
        }
    }
}
