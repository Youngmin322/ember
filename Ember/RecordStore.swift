//
//  RecordStore.swift
//  Ember
//

import Foundation
import Observation

struct EmberRecord: Codable, Identifiable, Hashable {
    let id: UUID
    let title: String
    let content: String
    let createdAt: Date
}

@MainActor
@Observable
final class RecordStore {
    private(set) var records: [EmberRecord] {
        didSet { persist() }
    }

    private let storageKey = "ember.records"

    init() {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let savedRecords = try? JSONDecoder().decode([EmberRecord].self, from: data)
        else {
            records = []
            return
        }
        records = savedRecords
    }

    var latestRecord: EmberRecord? {
        records.max(by: { $0.createdAt < $1.createdAt })
    }

    func add(title: String, content: String) {
        records.append(
            EmberRecord(
                id: UUID(),
                title: title,
                content: content,
                createdAt: .now
            )
        )
    }

    func recordCount(inWeekOf date: Date = .now, calendar: Calendar = .current) -> Int {
        guard let interval = calendar.dateInterval(of: .weekOfYear, for: date) else { return 0 }
        let recordedDays = records
            .filter { interval.contains($0.createdAt) }
            .map { calendar.startOfDay(for: $0.createdAt) }
        return Set(recordedDays).count
    }

    func hasRecord(on date: Date, calendar: Calendar = .current) -> Bool {
        records.contains { calendar.isDate($0.createdAt, inSameDayAs: date) }
    }

    private func persist() {
        guard let data = try? JSONEncoder().encode(records) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }
}
