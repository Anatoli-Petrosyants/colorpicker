//
//  AnyTransition+Extensions.swift
//  ColorPicker
//
//  Created by Anatoli Petrosyants on 11.11.24.
//

import SwiftUI

extension AnyTransition {
    static var delayAndFade: AnyTransition {
        return AnyTransition.identity
              .combined(with: .opacity)
              .animation(.default.delay(0.1))
    }
}
