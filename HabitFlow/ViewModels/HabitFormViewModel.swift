import Foundation
import SwiftData

@Observable
class HabitFormViewModel {
    var name: String = ""
    var emoji: String = "⭐"
    var colorHex: String = "#5E5CE6"
    var frequency: Set<Int> = [1, 2, 3, 4, 5]
    var reminderEnabled: Bool = false
    var reminderTime: Date = {
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }()

    var isEditing: Bool { editingHabit != nil }
    private var editingHabit: Habit?

    var isValid: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        name.count <= 50 &&
        !frequency.isEmpty
    }

    func configure(with habit: Habit) {
        editingHabit = habit
        name = habit.name
        emoji = habit.emoji
        colorHex = habit.colorHex
        frequency = Set(habit.frequency)
        reminderEnabled = habit.reminderTime != nil
        if let time = habit.reminderTime {
            reminderTime = time
        }
    }

    func save(context: ModelContext) {
        let trimmedName = name.trimmingCharacters(in: .whitespaces)

        if let habit = editingHabit {
            habit.name = trimmedName
            habit.emoji = emoji
            habit.colorHex = colorHex
            habit.frequency = Array(frequency).sorted()
            habit.reminderTime = reminderEnabled ? reminderTime : nil

            if habit.reminderTime != nil {
                NotificationService.shared.schedule(for: habit)
            } else {
                NotificationService.shared.cancel(for: habit)
            }
        } else {
            let habit = Habit(
                name: trimmedName,
                emoji: emoji,
                colorHex: colorHex,
                frequency: Array(frequency).sorted(),
                reminderTime: reminderEnabled ? reminderTime : nil
            )
            context.insert(habit)

            if habit.reminderTime != nil {
                NotificationService.shared.schedule(for: habit)
            }
        }

        try? context.save()
    }
}
