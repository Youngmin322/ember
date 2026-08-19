//
//  HomeView.swift
//  Ember
//

import SwiftUI

struct HomeView: View {
    let recordStore: RecordStore
    @State private var isQuickRecordPresented = false
    @State private var isDetailRecordPresented = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                header
                todayCard
                rhythmCard
                memoryCard
            }
            .padding(.horizontal, EmberLayout.screenHorizontalPadding)
            .padding(.top, 10)
            .padding(.bottom, 30)
        }
        .scrollIndicators(.hidden)
        .background(Color.emberBackground)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isQuickRecordPresented) {
            QuickRecordView { title, content in
                recordStore.add(title: title, content: content)
            } onOpenDetail: {
                isDetailRecordPresented = true
            }
            .presentationDetents([.height(444)])
            .presentationDragIndicator(.visible)
            .presentationCornerRadius(28)
        }
        .navigationDestination(isPresented: $isDetailRecordPresented) {
            DetailedRecordView { title, content in
                recordStore.add(title: title, content: content)
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("8월 19일 화요일")
                .font(.emberMetadata)
                .foregroundStyle(Color.emberTextSecondary)
            Text("오늘의 기록")
                .font(.emberScreenTitle)
                .foregroundStyle(Color.emberTextPrimary)
        }
    }

    private var todayCard: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(hasTodayRecord ? "오늘의 불꽃" : "오늘 떠오른 마음")
                        .font(.emberControl)
                        .foregroundStyle(Color.emberAccentText)
                    Text(hasTodayRecord ? latestRecordTitle : "지금 가장 마음에 남는 것은 무엇인가요?")
                        .font(.emberBodyEmphasis)
                        .foregroundStyle(Color.emberTextPrimary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                Spacer()
                EmberJar(size: .hero)
            }
            if hasTodayRecord {
                Label("업무 집중 모드에 연결됨", systemImage: "link")
                    .font(.emberMetadata)
                    .foregroundStyle(Color.emberAccentText)
                    .padding(.horizontal, 12)
                    .frame(height: 28)
                    .background(Color.emberSurfaceFocus, in: Capsule())
                    .padding(.top, 8)
            }
            Button { isQuickRecordPresented = true } label: {
                Text(hasTodayRecord ? "오늘 기록 다시 보기" : "오늘의 기록 시작하기")
            }
            .buttonStyle(.emberPrimary(size: .compact))
            .padding(.top, hasTodayRecord ? 14 : 24)
        }
        .padding(20)
        .emberCardStyle(fill: .emberSurfaceHighlight, border: .emberBorderSubtle, cornerRadius: EmberRadius.card, hasShadow: true)
    }

    private var rhythmCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("이번 주 기록 리듬").font(.emberSectionTitle)
                Spacer()
                Text("\(recordStore.recordCount(inWeekOf: .now)) / 7")
                    .font(.emberMetadata)
                    .foregroundStyle(Color.emberTextSecondary)
            }
            HStack(spacing: 0) {
                ForEach(Array(["월", "화", "수", "목", "금", "토", "일"].enumerated()), id: \.offset) { index, day in
                    VStack(spacing: 7) {
                        Text(day).font(.emberCaption).foregroundStyle(Color.emberTextSecondary)
                        ZStack {
                            Circle().fill(isToday(index) ? Color.emberAccent : Color.emberSurfaceSubtle).frame(width: 28, height: 28)
                            if hasRecord(onWeekdayIndex: index) {
                                Image(systemName: "flame.fill")
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundStyle(isToday(index) ? Color.white : Color.emberAccent)
                            } else if isToday(index) {
                                Image(systemName: "plus").font(.system(size: 13, weight: .bold)).foregroundStyle(Color.white)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(16)
        .emberCardStyle(fill: .emberSurfaceDefault, border: .emberBorderSubtle, cornerRadius: EmberRadius.large)
    }

    private var memoryCard: some View {
        HStack(spacing: 14) {
            VStack(alignment: .leading, spacing: 6) {
                Text("다시 만난 불꽃").font(.emberControl).foregroundStyle(Color.emberAccentText)
                Text("그때의 결심을 오늘 다시 꺼내볼까요?").font(.emberBodyEmphasis).foregroundStyle(Color.emberTextPrimary)
                Text("84일 전의 기록 보기").font(.emberMetadata).foregroundStyle(Color.emberTextSecondary).padding(.top, 8)
            }
            Spacer(minLength: 4)
            EmberJar(size: .small)
        }
        .padding(18)
        .emberCardStyle(fill: .emberSurfaceSubtle, border: .emberBorderSubtle, cornerRadius: EmberRadius.large)
    }

    private var hasTodayRecord: Bool {
        recordStore.hasRecord(on: .now)
    }

    private var latestRecordTitle: String {
        recordStore.latestRecord?.title ?? ""
    }

    private func isToday(_ weekdayIndex: Int) -> Bool {
        weekdayIndex == Calendar.current.component(.weekday, from: .now).advanced(by: 5) % 7
    }

    private func hasRecord(onWeekdayIndex weekdayIndex: Int) -> Bool {
        guard let week = Calendar.current.dateInterval(of: .weekOfYear, for: .now),
              let date = Calendar.current.date(byAdding: .day, value: weekdayIndex, to: week.start) else {
            return false
        }
        return recordStore.hasRecord(on: date)
    }
}

#Preview { NavigationStack { HomeView(recordStore: RecordStore()) } }
