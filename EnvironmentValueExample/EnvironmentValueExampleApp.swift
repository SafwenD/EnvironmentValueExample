//
//  EnvironmentValueExampleApp.swift
//  EnvironmentValueExample
//
//  Created by Safwen DEBBICHI on 01/06/2024.
//

import SwiftUI

@main
struct EnvironmentValueExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
                .modifier(DynamicEnvironmentModifier(keyPath: \.someEnvironmentValue, proxy: .init()))
        }
    }
}
