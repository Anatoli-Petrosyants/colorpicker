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

//@main
//struct ColorPickerApp: App {
//    @State private var changedTitle: String = "test"
//    
//    var body: some Scene {
//        WindowGroup {
//            VStack {
//                
//            }
//            .padding()
//            .onAppear {
//                print(Configuration.current.buildConfiguration)
//            }
//        }
//    }
//}

//PlayerView(title: changedTitle)
//
//Button("Change title") {
//    changedTitle = "Change"
//}

//struct PlayerView: View {
//    let title: String
//    @State private var isPlaying: Bool = false
//    
//    var body: some View {
//        VStack {
//            // Display information about the episode.
//            Text(title)
//
//            Button(action: {
//                self.isPlaying.toggle()
//            }) {
//                Image(systemName: isPlaying ? "pause.circle" : "play.circle")
//            }
//        }
//    }
//}
//
//#Preview {
//    PlayerView(title: "test")
//}
