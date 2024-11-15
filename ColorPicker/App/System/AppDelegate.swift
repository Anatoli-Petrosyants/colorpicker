//
//  AppDelegate.swift
//  ColorPicker
//
//  Created by Anatoli Petrosyants on 12.11.24.
//

import UIKit
import SwiftUI
import ComposableArchitecture

/// The application delegate responsible for handling app-level events.
final class AppDelegate: UIResponder, UIApplicationDelegate {

    /// The main store of the Composable Architecture.
    let store = Store(initialState: AppFeature.State()) {
        AppFeature()
    }
    
    /// The method called when the application finishes launching.
    ///
    /// - Parameters:
    ///   - application: The singleton app object.
    ///   - launchOptions: A dictionary indicating the reason the app was launched (if any).
    /// - Returns: `true` if the app was launched successfully; otherwise, `false`.
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        // Send an initial action to the store indicating that the app has finished launching
        self.store.send(.appDelegate(.didFinishLaunching))
        return true
    }
    
    /// The method called to provide a UISceneConfiguration.
    ///
    /// - Parameters:
    ///   - application: The singleton app object.
    ///   - connectingSceneSession: The new UISceneSession being created.
    ///   - options: A dictionary of details about the launch environment.
    /// - Returns: The newly created scene configuration.
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        // Check if the app was launched with a quick action
        if let shortcutItem = options.shortcutItem {
            self.store.send(.appDelegate(.didLaunchedWithShortcutItem(shortcutItem)))
        }

        // Create and configure the scene configuration
        let configuration = UISceneConfiguration(
            name: connectingSceneSession.configuration.name,
            sessionRole: connectingSceneSession.role
        )
        configuration.delegateClass = SceneDelegate.self
        return configuration
    }
}
