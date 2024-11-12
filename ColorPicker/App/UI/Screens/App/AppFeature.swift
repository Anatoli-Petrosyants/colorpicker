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
        case main(MainFeature.State)

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
        case main(MainFeature.Action)
    }
    
    @Dependency(\.userDefaultsClient) var userDefaultsClient
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .appDelegate(appDelegateAction):
                switch appDelegateAction {
                case .didFinishLaunching:
                    // Configure Logger
                    // Log.initialize()
                    return .none
                    
                case let .didLaunchedWithShortcutItem(shortcutItem):
                    // Log.info("didLaunchedWithShortcutItem: \(shortcutItem.type)")
                    return .none
                }
                
            case let .didChangeScenePhase(phase):
                // Log.info("didChangeScenePhase \(phase)")
                return .none
                
            case let .loading(action: .delegate(loadingAction)):
                switch loadingAction {
                case .didLoaded:
                    if self.userDefaultsClient.hasShownFirstLaunchOnboarding {
                        state = .main(MainFeature.State())
                    } else {
                        state = .onboarding(OnboardingFeature.State())
                    }
                    return .none
                }
                
            case let .onboarding(action: .delegate(onboardingAction)):
                switch onboardingAction {
                case .didOnboardingFinished:
                    state = .main(MainFeature.State())
                    return .none
                }

            case .loading, .onboarding, .main:
                return .none
            }
        }
        .ifCaseLet(/State.loading, action: /Action.loading) {
            LoadingFeature()
        }
        .ifCaseLet(/State.onboarding, action: /Action.onboarding) {
            OnboardingFeature()
        }
        .ifCaseLet(/State.main, action: /Action.main) {
            MainFeature()
        }
    }
}

//
//@Reducer
//struct AppFeature {
//
//    @ObservableState
//    enum State {
//        case loading(LoadingFeature.State)
//        case onboarding(OnboardingFeature.State)
//        case main(MainFeature.State)
//
//        public init() { self = .loading(LoadingFeature.State()) }
//    }
//
//    enum Action {
////        enum AppDelegateAction: Equatable {
////            case didFinishLaunching
////            case didLaunchedWithShortcutItem(UIApplicationShortcutItem)
////        }
////        
////        case appDelegate(AppDelegateAction)
////        case didChangeScenePhase(ScenePhase)
//        
//        case loading(LoadingFeature.Action)
//        case onboarding(OnboardingFeature.Action)
//        case main(MainFeature.Action)
//    }
//    
//    @Dependency(\.userDefaultsClient) var userDefaultsClient
//    
//    var body: some Reducer<State, Action> {
//        Reduce { state, action in
//            switch action {
////            case let .appDelegate(appDelegateAction):
////                switch appDelegateAction {
////                case .didFinishLaunching:
////                    // Configure Logger
////                    // Log.initialize()
////                    print("didFinishLaunching")
////                    return .none
////                    
////                case let .didLaunchedWithShortcutItem(shortcutItem):
//////                    Log.info("didLaunchedWithShortcutItem: \(shortcutItem.type)")
////                    
//////                    let action = QuickAction(shortcutItem: shortcutItem)
//////                    switch action {
//////                    case .favourites:
//////                        state = .main(MainFeature.State(currentTab: .wishlist))
//////                    case .basket:
//////                        state = .main(MainFeature.State(currentTab: .basket))
//////                    default:
//////                        break
//////                    }
////
////                    return .none
////                }
////                
////            case let .didChangeScenePhase(phase):
//////                Log.info("didChangeScenePhase \(phase)")
////                return .none
//
//            case let .loading(action: .delegate(loadingAction)):
//                switch loadingAction {
//                case .didLoaded:
//                    if self.userDefaultsClient.hasShownFirstLaunchOnboarding {
//                        state = .main(MainFeature.State())
//                    } else {
//                        state = .onboarding(OnboardingFeature.State())
//                    }
//                    return .none
//                }
//                
//            case let .onboarding(action: .delegate(onboardingAction)):
//                switch onboardingAction {
//                case .didOnboardingFinished:
//                    state = .join(MainFeature.State())
//                    return .none
//                }
//
//            case .loading, .onboarding, .main:
//                return .none
//            }
//        }
//        .ifCaseLet(/State.loading, action: /Action.loading) {
//            LoadingFeature()
//        }
//        .ifCaseLet(/State.onboarding, action: /Action.onboarding) {
//            OnboardingFeature()
//        }
//        .ifCaseLet(/State.main, action: /Action.main) {
//            MainFeature()
//        }
//    }
//}
