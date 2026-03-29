import Foundation
import SwiftData
import SwiftUI

@Observable
class HabitListViewModel {
    var showingForm = false
    var habitToEdit: Habit?

    func toggleCompletion(for habit: Habit, context: ModelContext) {
        let today = Calendar.current.startOfDay(for: Date())

        if let existingEntry = habit.entries.first(where: {
            Calendar.current.startOfDay(for: $0.date) == today && $0.completed
        }) {
            context.delete(existingEntry)
        } else {
            let entry = HabitEntry(date: Date(), completed: true)
            entry.habit = habit
            habit.entries.append(entry)
            context.insert(entry)
        }

        try? context.save()
    }

    func deleteHabit(_ habit: Habit, context: ModelContext) {
        NotificationService.shared.cancel(for: habit)
        context.delete(habit)
        try? context.save()
    }

    var todaysHabits: (habits: [Habit], completed: Int) {
        return ([], 0)
    }
}
