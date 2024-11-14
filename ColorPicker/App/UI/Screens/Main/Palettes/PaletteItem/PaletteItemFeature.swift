//
//  PaletteItemFeature.swift
//  ColorPicker
//
//  Created by Anatoli Petrosyants on 14.11.24.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct PaletteItemFeature {
    
    @ObservableState
    struct State: Identifiable, Equatable {
        let id: UUID
        let palette: Palette
    }
    
    enum Action: Equatable {
        enum ViewAction: Equatable {
            case onItemTap
        }
        
        enum Delegate: Equatable {
            case didItemTapped(Palette)
        }
        
        case view(ViewAction)
        case delegate(Delegate)
    }
    
    @Dependency(\.feedbackGenerator) var feedbackGenerator
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .view(viewAction):
                switch viewAction {
                case .onItemTap:
                    return .send(.delegate(.didItemTapped(state.palette)))
                }
                
            case .delegate:
                return .none
            }
        }
    }
}
