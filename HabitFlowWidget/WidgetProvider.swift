import WidgetKit
import SwiftUI

struct HabitWidgetEntry: TimelineEntry {
    let date: Date
    let habits: [HabitSnapshot]
    let completedCount: Int
    let totalCount: Int
}

struct HabitSnapshot: Identifiable, Codable {
    let id: UUID
    let name: String
    let emoji: String
    let colorHex: String
    let isCompleted: Bool
}

struct WidgetProvider: TimelineProvider {
    func placeholder(in context: Context) -> HabitWidgetEntry {
        HabitWidgetEntry(
            date: Date(),
            habits: [
                HabitSnapshot(id: UUID(), name: "Beber água", emoji: "💧", colorHex: "#007AFF", isCompleted: true),
                HabitSnapshot(id: UUID(), name: "Ler 30 min", emoji: "📚", colorHex: "#34C759", isCompleted: true),
                HabitSnapshot(id: UUID(), name: "Exercitar", emoji: "🏃", colorHex: "#FF9500", isCompleted: false),
                HabitSnapshot(id: UUID(), name: "Meditar", emoji: "🧘", colorHex: "#5E5CE6", isCompleted: false)
            ],
            completedCount: 2,
            totalCount: 4
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (HabitWidgetEntry) -> Void) {
        completion(loadEntry())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<HabitWidgetEntry>) -> Void) {
        let entry = loadEntry()
        let nextUpdate = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }

    private func loadEntry() -> HabitWidgetEntry {
        guard let defaults = UserDefaults(suiteName: "group.br.geozedeque.habitflow"),
              let data = defaults.data(forKey: "widgetHabits"),
              let snapshots = try? JSONDecoder().decode([HabitSnapshot].self, from: data)
        else {
            return HabitWidgetEntry(date: Date(), habits: [], completedCount: 0, totalCount: 0)
        }

        let completedCount = snapshots.filter(\.isCompleted).count
        return HabitWidgetEntry(
            date: Date(),
            habits: snapshots,
            completedCount: completedCount,
            totalCount: snapshots.count
        )
    }
}
