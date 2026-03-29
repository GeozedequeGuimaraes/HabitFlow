import Foundation
import WidgetKit

struct WidgetHabitSnapshot: Codable {
    let id: UUID
    let name: String
    let emoji: String
    let colorHex: String
    let isCompleted: Bool
}

enum WidgetDataService {
    private static let suiteName = "group.br.geozedeque.habitflow"
    private static let key = "widgetHabits"

    static func update(habits: [Habit]) {
        let today = Calendar.current.startOfDay(for: Date())
        let weekday = Calendar.current.component(.weekday, from: Date())
        let adjusted = weekday == 1 ? 7 : weekday - 1

        let todaysHabits = habits.filter { $0.frequency.contains(adjusted) }

        let snapshots = todaysHabits.map { habit in
            let isCompleted = habit.entries.contains {
                Calendar.current.startOfDay(for: $0.date) == today && $0.completed
            }
            return WidgetHabitSnapshot(
                id: habit.id,
                name: habit.name,
                emoji: habit.emoji,
                colorHex: habit.colorHex,
                isCompleted: isCompleted
            )
        }

        if let data = try? JSONEncoder().encode(snapshots) {
            UserDefaults(suiteName: suiteName)?.set(data, forKey: key)
        }

        WidgetCenter.shared.reloadAllTimelines()
    }
}
