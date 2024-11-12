//
//  ProgressViewWrapper.swift
//  ColorPicker
//
//  Created by Anatoli Petrosyants on 12.11.24.
//

import SwiftUI

struct ProgressViewWrapper: View {
    @Binding var progress: Double
    
    var body: some View {
        ProgressView(value: progress)
            .background(Color.gray)
            .tint(Color.black)
            .scaleEffect(0.5, anchor: .center)
            .frame(width: 202, height: 2, alignment: .center)
    }
}
