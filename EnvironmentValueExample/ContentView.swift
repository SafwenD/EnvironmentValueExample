//
//  ContentView.swift
//  EnvironmentValueExample
//
//  Created by Safwen DEBBICHI on 01/06/2024.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.someEnvironmentValue) @Binding var someEnvironmentValue: SomeDynamicEnvironmentValue
    @State var isPresented: Bool = false
    var body: some View {
        NavigationStack {
            VStack(spacing: 50) {
                Text("Value: "+someEnvironmentValue.value)
                    .font(.title)
                Button(action: {
                    isPresented.toggle()
                }, label: {
                    Text("Next")
                })
            }
            .padding()
            .navigationDestination(isPresented: $isPresented) {
                FirstView()
            }
        }
    }
}

struct FirstView: View {
    @Environment(\.someEnvironmentValue) @Binding var someEnvironmentValue: SomeDynamicEnvironmentValue
    var body: some View {
        VStack(spacing: 50) {
            TextField("field", text: _someEnvironmentValue.wrappedValue.value)
                .textFieldStyle(.roundedBorder)
        }
        .padding()
    }
}

struct SomeDynamicEnvironmentValue: DynamicEnvironment {
    var id: UUID = UUID()
    var value: String = ""
}

struct SomeEnvironmentValueKey: EnvironmentKey {
    static let defaultValue: Binding<SomeDynamicEnvironmentValue> = .constant(.init())
}

extension EnvironmentValues {
    var someEnvironmentValue: Binding<SomeDynamicEnvironmentValue> {
        get { self[SomeEnvironmentValueKey.self] }
        set { self[SomeEnvironmentValueKey.self] = newValue }
    }
}

typealias DynamicEnvironmentKeyPath<Env: DynamicEnvironment> = WritableKeyPath<EnvironmentValues, Binding<Env>>

protocol DynamicEnvironment {
    var id: UUID { get }
}

struct DynamicEnvironmentModifier<Env: DynamicEnvironment>: ViewModifier {
    var keyPath: DynamicEnvironmentKeyPath<Env>
    @State var proxy: Env
    
    func body(content: Content) -> some View {
        content
            .environment(keyPath, $proxy)
    }
}
