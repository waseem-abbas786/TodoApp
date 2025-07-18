//
//  ContentView.swift
//  TodoApp
//
//  Created by Waseem Abbas on 17/07/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TodoView()
            .tabItem {
                Label("Todo", systemImage: "list.bullet")
            }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
