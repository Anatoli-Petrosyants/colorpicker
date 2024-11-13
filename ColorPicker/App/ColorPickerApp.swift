//
//  ColorPickerApp.swift
//  ColorPicker
//
//  Created by Anatoli Petrosyants on 11.11.24.
//

import SwiftUI
import ComposableArchitecture
import XCTestDynamicOverlay

@main
struct Showcase: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            if !_XCTIsTesting {
                AppView(store: self.appDelegate.store)
            }
        }
        .onChange(of: scenePhase) { (phase, _) in
            self.appDelegate.store.send(.didChangeScenePhase(phase))
        }
    }
}
