//
//  Localization.swift
//  ColorPicker
//
//  Created by Anatoli Petrosyants on 11.11.24.
//

import SwiftUI

public enum Localization {}

extension Localization {
    enum Base {
        static var colorPicker: LocalizedStringKey { return "base.colorPicker" }
        static var `continue`: LocalizedStringKey { return "base.continue" }
        static var ok: LocalizedStringKey { return "base.ok" }
        static var save: LocalizedStringKey { return "base.save" }
        static var cancel: LocalizedStringKey { return "base.cancel" }
        static var done: LocalizedStringKey { return "base.done" }
        static var close: LocalizedStringKey { return "base.close" }
        static var attention: LocalizedStringKey { return "base.attention" }
        static var oops: LocalizedStringKey { return "base.oops" }
        static var noNetworkConnection: LocalizedStringKey { return "base.no.network.connection" }
    }
}
