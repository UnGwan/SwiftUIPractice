//
//  ContentView.swift
//  TCAPractice
//
//  Created by 정운관 on 5/14/24.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    var body: some View {
        VStack {
            List {
                NavigationLink {
                    MVVMView()
                } label: {
                    Text("MVVM")
                }
                NavigationLink {
                    TCAView(store: Store(initialState: Feature.State()) {
                        Feature()
                      })
                } label: {
                    Text("TCA")
                }
            }
        }
//        .padding()
    }
}

#Preview {
    ContentView()
}
