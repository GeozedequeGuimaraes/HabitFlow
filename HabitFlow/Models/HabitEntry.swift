import Foundation
import SwiftData

@Model
class HabitEntry {
    var id: UUID
    var date: Date
    var completed: Bool
    var note: String?

    var habit: Habit?

    init(date: Date = Date(), completed: Bool = true, note: String? = nil) {
        self.id = UUID()
        self.date = Calendar.current.startOfDay(for: date)
        self.completed = completed
        self.note = note
    }
}
