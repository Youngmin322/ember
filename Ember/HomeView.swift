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
                        GridItem(.flexible(), spacing: 16),
                        GridItem(.flexible())
                    ],
                    spacing: 16
                ) {
                    Button(action: onQuickRecord) {
                        VStack(alignment: .leading, spacing: 8) {
                            Image(.quickRecordIllustration)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 38, height: 38)
                            
                            Text("빠른 기록")
                                .font(.emberSectionTitle)
                                
                            Text("떠오른 마음을\n한 문장으로")
                                .font(.emberBody)
                        }
                        .padding(16)
                        .frame(
                            maxWidth: .infinity,
                            minHeight: 170,
                            alignment: .topLeading
                        )
                        .background {
                            RoundedRectangle(
                                cornerRadius: 18,
                                style: .continuous
                            )
                            .fill(Color.surfaceDefault)
                        }
                    }
                    .buttonStyle(.plain)
                    
                    Button(action: onDetailRecord) {
                        VStack(alignment: .leading, spacing: 8) {
                            Image(.detailRecordIllustration)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 38, height: 38)
                            
                            Text("상세 기록")
                                .font(.emberSectionTitle)
                                
                            Text("상황과 생각까지\n천천히 자세히")
                                .font(.emberBody)
                        }
                        .padding(16)
                        .frame(
                            maxWidth: .infinity,
                            minHeight: 170,
                            alignment: .topLeading
                        )
                        .background {
                            RoundedRectangle(
                                cornerRadius: 18,
                                style: .continuous
                            )
                            .fill(Color.surfaceSubtle)
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
        .background(Color.appBackground.ignoresSafeArea())
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
                .font(.emberBodyEmphasis)
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
        .font(.emberCaption)
        .foregroundStyle(Color.textSecondary)
    }
}

//private struct NewFlameActionsSection: View {
//    let onQuickRecord: () -> Void
//    let onDetailRecord: () -> Void
//    
//    private let colums = [
//        GridItem(.flexible(), spacing: Layout.cardSpacing)
//    ]
//        
//    var body: some View {
//        VStack(alignment: .leading, spacing: Layout.contentSpacing) {
//            Text("새로운 불꽃 담기")
//                .font(.emberSectionTitle)
//                .foregroundStyle(Color.textPrimary)
//
//            LazyVGrid(columns: columns, spacing: Layout.cardSpacing) {
//                HomeActionCard(
//                    action: .quick,
//                    onTap: onQuickRecord
//                )
//
//                HomeActionCard(
//                    action: .detail,
//                    onTap: onDetailRecord
//                )
//            }
//        }
//    }
//}
//
//private extension NewFlameActionsSection {
//    enum Layout {
//        static let contentSpacing: CGFloat = 14
//        static let cardSpacing: CGFloat = 16
//    }
//}


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
