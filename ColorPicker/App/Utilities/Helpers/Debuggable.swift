//
//  Debuggable.swift
//  ColorPicker
//
//  Created by Anatoli Petrosyants on 14.11.24.
//

import Foundation

@propertyWrapper
struct Debuggable<Value> {
    private var value: Value
    private let description: String

    init(wrappedValue: Value, description: String = "") {
        print("Initialized '\(description)' with value \(wrappedValue)")
        self.value = wrappedValue
        self.description = description
    }

    var wrappedValue: Value {
        get {
            print("Accessing '\(description)', returning: \(value)")
            return value
        }
        set {
            print("Updating '\(description)', newValue: \(newValue)")
            value = newValue
        }
    }
}
