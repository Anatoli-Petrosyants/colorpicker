//
//  Blocks.swift
//  ColorPicker
//
//  Created by Anatoli Petrosyants on 11.11.24.
//

import Foundation

typealias EmptyBlock                    = () -> Void
typealias Block<T>                      = (T) -> Void
typealias InputOutputBlock<T, O>        = (T) -> O
typealias ResultBlock<T, E: Error>      = (Result<T, E>) -> Void
typealias URLBlock                      = (URL?) -> Void
