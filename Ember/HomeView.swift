//
//  HomeView.swift
//  Ember
//
//  Created by Youngmin Cho on 8/11/26.
//

import SwiftUI

struct HomeView: View {
    let rediscoveredFlame: RediscoveredFlameSummary
    let onQuickRecord: () -> Void
    let onDetailRecord: () -> Void
    
    var body: some View {
        Title
        
        ScrollView {
            VStack(alignment: .leading, spacing: Layout.sectionSpacing) {
                RediscoveredFlameCard(flame: rediscoveredFlame)
                
                Text("새로운 불꽃 담기")
                    .font(.emberSectionTitle)
                
                LazyVGrid(
                    columns: [
                        GridItem(.flexible(), spacing: EmberSpacing.medium),
                        GridItem(.flexible())
                    ],
                    spacing: EmberSpacing.medium
                ) {
                    Button(action: onQuickRecord) {
                        VStack(alignment: .leading, spacing: EmberSpacing.xSmall) {
                            Image(.quickRecordIllustration)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 38, height: 38)
                            
                            Text("빠른 기록")
                                .font(.emberSectionTitle)
                                
                            Text("떠오른 마음을\n한 문장으로")
                                .font(.emberBody)
                        }
                        .padding(EmberSpacing.medium)
                        .frame(
                            maxWidth: .infinity,
                            minHeight: 170,
                            alignment: .topLeading
                        )
                        .background {
                            RoundedRectangle(
                                cornerRadius: EmberRadius.large,
                                style: .continuous
                            )
                            .fill(Color.emberSurfaceHighlight)
                        }
                    }
                    .buttonStyle(.plain)
                    
                    Button(action: onDetailRecord) {
                        VStack(alignment: .leading, spacing: EmberSpacing.xSmall) {
                            Image(.detailRecordIllustration)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 38, height: 38)
                            
                            Text("상세 기록")
                                .font(.emberSectionTitle)
                                
                            Text("상황과 생각까지\n천천히 자세히")
                                .font(.emberBody)
                        }
                        .padding(EmberSpacing.medium)
                        .frame(
                            maxWidth: .infinity,
                            minHeight: 170,
                            alignment: .topLeading
                        )
                        .background {
                            RoundedRectangle(
                                cornerRadius: EmberRadius.large,
                                style: .continuous
                            )
                            .fill(Color.emberSurfaceSubtle)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, Layout.horizontalPadding)
            .padding(.top, Layout.topPadding)
        }
        .scrollIndicators(.hidden)
        .background(Color.emberBackground.ignoresSafeArea())
    }
    
    private var Title: some View {
        VStack {
            Text("Ember")
                .font(
                    .system(
                        .largeTitle,
                        design: .rounded,
                        weight: .bold
                    )
                    .width(.condensed)
                )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, Layout.horizontalPadding)
        .padding(.top)
    }
}

private extension HomeView {
    enum Layout {
        static let horizontalPadding = EmberLayout.screenHorizontalPadding
        static let topPadding = EmberSpacing.xLarge
        static let sectionSpacing = EmberSpacing.xLarge
    }
}


// MARK: - Rediscovered Flame Card

private struct RediscoveredFlameCard: View {
    let flame: RediscoveredFlameSummary
    
    var body: some View {
        VStack(alignment: .leading, spacing: Layout.contentSpacing) {
            Text("오늘 다시 만난 불꽃")
                .font(.emberLabel)
                .foregroundStyle(Color.emberAccentText)
            
            Text("“\(flame.message)”")
                .font(.emberBodyEmphasis)
                .foregroundStyle(Color.emberTextPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            metadata
        }
        .padding(.horizontal, Layout.horizontalPadding)
        .padding(.vertical, Layout.verticalPadding)
        .frame(maxWidth: .infinity, alignment: .leading)
        .emberCardStyle(
            fill: .emberSurfaceSubtle,
            border: .emberBorderSubtle,
            cornerRadius: Layout.cornerRadius,
            hasShadow: true
        )
        .accessibilityElement(children: .combine)
    }
    
    private var metadata: some View {
        HStack(spacing: Layout.metadataSpacing) {
            Text("\(flame.elapsedDays)일 전")
            
            Text("·")
            
            Image(systemName: "arrow.counterclockwise")
            
            Text("\(flame.revisitCount)")
        }
        .font(.emberCaption)
        .foregroundStyle(Color.emberTextSecondary)
    }
}

private extension RediscoveredFlameCard {
    enum Layout {
        static let contentSpacing: CGFloat = 15
        static let horizontalPadding = EmberSpacing.medium
        static let verticalPadding: CGFloat = 14
        static let metadataSpacing = EmberSpacing.xxSmall
        static let cornerRadius = EmberRadius.card
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
        message: "Swift 기본기 연습하기",
        elapsedDays: 84,
        revisitCount: 3
    )
}


#Preview {
    NavigationStack {
        HomeView(
            rediscoveredFlame: .sample,
            onQuickRecord: {},
            onDetailRecord: {}
        )
    }
}
