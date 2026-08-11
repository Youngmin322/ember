//
//  HomeView.swift
//  Ember
//
//  Created by Youngmin Cho on 8/11/26.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color("AppBackground")
                .ignoresSafeArea()
        }
        .navigationTitle("Ember")
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
