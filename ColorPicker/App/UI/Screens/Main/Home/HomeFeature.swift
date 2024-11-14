//
//  HomeFeature.swift
//  ColorPicker
//
//  Created by Anatoli Petrosyants on 12.11.24.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct HomeFeature {
    
    @ObservableState
    struct State {
        var color = UIColor.clear
        var currentPalette: Palette = Palette.clear
        var palettes: [Palette] = []
    }
    
    enum Action: BindableAction {
        enum ViewAction {
            case onTapColor
        }
        
        case binding(BindingAction<State>)
        case view(ViewAction)
    }

    
    var body: some Reducer<State, Action> {
        BindingReducer()
        
        Reduce { state, action in
          switch action {              
          case let .view(viewAction):
              switch viewAction {
              case .onTapColor:
                  let palette = state.color.palette
                  state.palettes.append(palette)
                  return .none
              }

          case .binding(\.color):
              state.currentPalette = state.color.palette
              return .none

          case .binding:
              return .none
          }
        }
    }
}
