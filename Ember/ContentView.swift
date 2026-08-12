//
//  ContentView.swift
//  Ember
//
//  Created by Youngmin Cho on 8/11/26.
//

import SwiftUI

struct ContentView: View {
    @State private var isQuickRecordPresented = false
    
    var body: some View {
        TabView {
            Tab("홈", systemImage: "house") {
                NavigationStack {
                    HomeView(
                        rediscoveredFlame: .sample,
                        onQuickRecord: {
                            isQuickRecordPresented = true
                        },
                        onDetailRecord: {}
                    )
                    .navigationDestination(isPresented: $isQuickRecordPresented) {
                        QuickRecordView()
                    }
                }
            }
            
            Tab("불꽃", systemImage: "flame") {
                NavigationStack {
                    Text("불꽃")
                        .navigationTitle("보관함")
                }
            }
            
            Tab("설정", systemImage: "gearshape") {
                NavigationStack {
                    Text("설정")
                        .navigationTitle("설정")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
