//
//  PalettesFeature.swift
//  ColorPicker
//
//  Created by Anatoli Petrosyants on 14.11.24.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct PalettesFeature {
    
    @ObservableState
    struct State {
        var count = 0
        var palettes: [Palette] = []
    }
    
    enum Action {
        enum ViewAction {
            case onAppear
        }
        
        case view(ViewAction)
    }

    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
          switch action {
          case let .view(viewAction):
              switch viewAction {
              case .onAppear:
                  state.count = state.palettes.count
                  return .none
              }
          }
        }
    }
}
