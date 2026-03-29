import Foundation
import SwiftData

@Model
class Habit {
    var id: UUID
    var name: String
    var emoji: String
    var colorHex: String
    var frequency: [Int]
    var reminderTime: Date?
    var createdAt: Date

    @Relationship(deleteRule: .cascade, inverse: \HabitEntry.habit)
    var entries: [HabitEntry]

    init(
        name: String,
        emoji: String = "⭐",
        colorHex: String = "#5E5CE6",
        frequency: [Int] = [1, 2, 3, 4, 5],
        reminderTime: Date? = nil
    ) {
        self.id = UUID()
        self.name = name
        self.emoji = emoji
        self.colorHex = colorHex
        self.frequency = frequency
        self.reminderTime = reminderTime
        self.createdAt = Date()
        self.entries = []
    }

    // MARK: - Computed Properties

    var isCompletedToday: Bool {
        let today = Calendar.current.startOfDay(for: Date())
        return entries.contains {
            Calendar.current.startOfDay(for: $0.date) == today && $0.completed
        }
    }

    var currentStreak: Int {
        var streak = 0
        var date = Calendar.current.startOfDay(for: Date())
        let calendar = Calendar.current

        while true {
            let hasEntry = entries.contains {
                calendar.startOfDay(for: $0.date) == date && $0.completed
            }
            guard hasEntry else { break }
            streak += 1
            guard let previous = calendar.date(byAdding: .day, value: -1, to: date) else { break }
            date = previous
        }
        return streak
    }

    var completionRateThisMonth: Double {
        let calendar = Calendar.current
        let now = Date()
        guard let startOfMonth = calendar.date(
            from: calendar.dateComponents([.year, .month], from: now)
        ) else { return 0 }

        let daysElapsed = (calendar.dateComponents([.day], from: startOfMonth, to: now).day ?? 0) + 1
        let completed = entries.filter { $0.date >= startOfMonth && $0.completed }.count
        return daysElapsed > 0 ? Double(completed) / Double(daysElapsed) : 0
    }

    var isScheduledForToday: Bool {
        let weekday = Calendar.current.component(.weekday, from: Date())
        let adjusted = weekday == 1 ? 7 : weekday - 1
        return frequency.contains(adjusted)
    }

    func entries(for month: Date) -> [HabitEntry] {
        let calendar = Calendar.current
        guard let startOfMonth = calendar.date(
            from: calendar.dateComponents([.year, .month], from: month)
        ),
        let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)
        else { return [] }

        return entries.filter { entry in
            entry.date >= calendar.startOfDay(for: startOfMonth) &&
            entry.date <= calendar.startOfDay(for: endOfMonth)
        }
    }

    var completionRateThisWeek: Double {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)) else { return 0 }

        var scheduledDays = 0
        var completedDays = 0

        for dayOffset in 0..<7 {
            guard let day = calendar.date(byAdding: .day, value: dayOffset, to: startOfWeek) else { continue }
            if day > today { break }

            let weekday = calendar.component(.weekday, from: day)
            let adjusted = weekday == 1 ? 7 : weekday - 1
            if frequency.contains(adjusted) {
                scheduledDays += 1
                let hasEntry = entries.contains {
                    calendar.startOfDay(for: $0.date) == day && $0.completed
                }
                if hasEntry { completedDays += 1 }
            }
        }
        return scheduledDays > 0 ? Double(completedDays) / Double(scheduledDays) : 0
    }
}
