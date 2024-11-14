//
//  AppFeature.swift
//  ColorPicker
//
//  Created by Anatoli Petrosyants on 12.11.24.
//

import ComposableArchitecture
import SwiftUI
import Foundation

@Reducer
struct AppFeature {
    
    @ObservableState
    enum State {
        case loading(LoadingFeature.State)
        case onboarding(OnboardingFeature.State)
        case home(HomeFeature.State)

        public init() { self = .loading(LoadingFeature.State()) }
    }
    
    enum Action {
        enum AppDelegateAction: Equatable {
            case didFinishLaunching
            case didLaunchedWithShortcutItem(UIApplicationShortcutItem)
        }
        
        case appDelegate(AppDelegateAction)
        case didChangeScenePhase(ScenePhase)
        
        case loading(LoadingFeature.Action)
        case onboarding(OnboardingFeature.Action)
        case home(HomeFeature.Action)
    }
    
    @Dependency(\.userDefaultsClient) var userDefaultsClient
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .appDelegate(appDelegateAction):
                switch appDelegateAction {
                case .didFinishLaunching:
                    // Configure Logger
                    print("didFinishLaunching")
                    return .none
                    
                case let .didLaunchedWithShortcutItem(shortcutItem):
                    print("didLaunchedWithShortcutItem", shortcutItem.type)
                    return .none
                }
                
            case let .didChangeScenePhase(phase):
                print("didChangeScenePhase", phase)
                return .none
                
            case let .loading(action: .delegate(loadingAction)):
                switch loadingAction {
                case .didLoaded:
                    if self.userDefaultsClient.hasShownFirstLaunchOnboarding {
                        state = .home(HomeFeature.State())
                    } else {
                        state = .onboarding(OnboardingFeature.State())
                    }
                    return .none
                }
                
            case let .onboarding(action: .delegate(onboardingAction)):
                switch onboardingAction {
                case .didOnboardingFinished:
                    state = .home(HomeFeature.State())
                    return .none
                }

            case .loading, .onboarding, .home:
                return .none
            }
        }
        .ifCaseLet(\.loading, action: \.loading) {
            LoadingFeature()
        }
        .ifCaseLet(\.onboarding, action: \.onboarding) {
            OnboardingFeature()
        }
        .ifCaseLet(\.home, action: \.home) {
            HomeFeature()
        }
    }
}
