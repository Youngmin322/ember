//
//  HomeView.swift
//  Ember
//
//  Created by Youngmin Cho on 8/11/26.
//

import SwiftUI

struct HomeView: View {
    let rediscoveredFlame: RediscoveredFlameSummary

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Layout.sectionSpacing) {
                RediscoveredFlameCard(flame: rediscoveredFlame)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, Layout.horizontalPadding)
            .padding(.top, Layout.topPadding)
        }
        .scrollIndicators(.hidden)
        .background(Color.appBackground.ignoresSafeArea())
        .navigationTitle("Ember")
    }
}

private extension HomeView {
    enum Layout {
        static let horizontalPadding: CGFloat = 24
        static let topPadding: CGFloat = 24
        static let sectionSpacing: CGFloat = 26
    }
}

// MARK: - Rediscovered Flame Card

private struct RediscoveredFlameCard: View {
    let flame: RediscoveredFlameSummary

    var body: some View {
        VStack(alignment: .leading, spacing: Layout.contentSpacing) {
            Text("오늘 다시 만난 불꽃")
                .font(.caption)
                .foregroundStyle(Color.accentColor)

            Text("“\(flame.message)”")
                .font(.subheadline.weight(.medium))
                .foregroundStyle(Color.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)

            metadata
        }
        .padding(.horizontal, Layout.horizontalPadding)
        .padding(.vertical, Layout.verticalPadding)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(
                cornerRadius: Layout.cornerRadius,
                style: .continuous
            )
            .fill(Color.surfaceSubtle)
        }
        .accessibilityElement(children: .combine)
    }

    private var metadata: some View {
        HStack(spacing: Layout.metadataSpacing) {
            Text("\(flame.elapsedDays)일 전")

            Text("·")

            Image(systemName: "arrow.counterclockwise")

            Text("\(flame.revisitCount)")
        }
        .font(.caption)
        .foregroundStyle(Color.textSecondary)
    }
}

private extension RediscoveredFlameCard {
    enum Layout {
        static let contentSpacing: CGFloat = 6
        static let horizontalPadding: CGFloat = 16
        static let verticalPadding: CGFloat = 14
        static let metadataSpacing: CGFloat = 4
        static let cornerRadius: CGFloat = 12
    }
}

// MARK: - Presentation Model

struct RediscoveredFlameSummary {
    let message: String
    let elapsedDays: Int
    let revisitCount: Int
}

extension RediscoveredFlameSummary {
    static let sample = RediscoveredFlameSummary(
        message: "나도 꾸준히 만드는 사람이 되고 싶다.",
        elapsedDays: 84,
        revisitCount: 3
    )
}

#Preview {
    NavigationStack {
        HomeView(rediscoveredFlame: .sample)
    }
}
