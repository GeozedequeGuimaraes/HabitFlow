import Foundation

@Observable
class StatsViewModel {
    var selectedMonth: Date = Date()

    var canGoForward: Bool {
        let calendar = Calendar.current
        let currentMonth = calendar.dateComponents([.year, .month], from: Date())
        let selected = calendar.dateComponents([.year, .month], from: selectedMonth)
        return selected.year! < currentMonth.year! ||
               (selected.year! == currentMonth.year! && selected.month! < currentMonth.month!)
    }

    func goToPreviousMonth() {
        if let newDate = Calendar.current.date(byAdding: .month, value: -1, to: selectedMonth) {
            selectedMonth = newDate
        }
    }

    func goToNextMonth() {
        guard canGoForward else { return }
        if let newDate = Calendar.current.date(byAdding: .month, value: 1, to: selectedMonth) {
            selectedMonth = newDate
        }
    }

    func completionsPerDay(habits: [Habit]) -> [(day: Int, count: Int)] {
        let calendar = Calendar.current
        guard let range = calendar.range(of: .day, in: .month, for: selectedMonth) else { return [] }

        return range.map { day in
            var components = calendar.dateComponents([.year, .month], from: selectedMonth)
            components.day = day
            guard let date = calendar.date(from: components) else { return (day, 0) }
            let startOfDay = calendar.startOfDay(for: date)

            let count = habits.reduce(0) { total, habit in
                let hasEntry = habit.entries.contains {
                    calendar.startOfDay(for: $0.date) == startOfDay && $0.completed
                }
                return total + (hasEntry ? 1 : 0)
            }
            return (day, count)
        }
    }

    func habitStats(habits: [Habit]) -> [HabitStatData] {
        let calendar = Calendar.current
        guard let startOfMonth = calendar.date(
            from: calendar.dateComponents([.year, .month], from: selectedMonth)
        ),
        let range = calendar.range(of: .day, in: .month, for: selectedMonth)
        else { return [] }

        let now = Date()
        let isCurrentMonth = calendar.isDate(selectedMonth, equalTo: now, toGranularity: .month)

        return habits.map { habit in
            var scheduledDays = 0
            var completedDays = 0

            for dayOffset in range {
                var components = calendar.dateComponents([.year, .month], from: selectedMonth)
                components.day = dayOffset
                guard let date = calendar.date(from: components) else { continue }

                if isCurrentMonth && date > now { break }

                let weekday = calendar.component(.weekday, from: date)
                let adjusted = weekday == 1 ? 7 : weekday - 1
                if habit.frequency.contains(adjusted) {
                    scheduledDays += 1
                    let startOfDay = calendar.startOfDay(for: date)
                    let hasEntry = habit.entries.contains {
                        calendar.startOfDay(for: $0.date) == startOfDay && $0.completed
                    }
                    if hasEntry { completedDays += 1 }
                }
            }

            let rate = scheduledDays > 0 ? Double(completedDays) / Double(scheduledDays) : 0

            return HabitStatData(
                habit: habit,
                completedDays: completedDays,
                scheduledDays: scheduledDays,
                rate: rate
            )
        }
    }

    func bestStreak(habits: [Habit]) -> Int {
        habits.map(\.currentStreak).max() ?? 0
    }

    func averageRate(habits: [Habit]) -> Double {
        let stats = habitStats(habits: habits)
        guard !stats.isEmpty else { return 0 }
        return stats.map(\.rate).reduce(0, +) / Double(stats.count)
    }

    func totalCompleted(habits: [Habit]) -> Int {
        habitStats(habits: habits).map(\.completedDays).reduce(0, +)
    }
}

struct HabitStatData: Identifiable {
    let habit: Habit
    let completedDays: Int
    let scheduledDays: Int
    let rate: Double

    var id: UUID { habit.id }
}
