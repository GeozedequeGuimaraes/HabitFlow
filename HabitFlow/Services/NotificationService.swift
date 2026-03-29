import UserNotifications

final class NotificationService: Sendable {

    static let shared = NotificationService()

    func requestAuthorization() async {
        try? await UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge])
    }

    func schedule(for habit: Habit) {
        guard let reminderTime = habit.reminderTime else { return }

        cancel(for: habit)

        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: reminderTime)
        let minute = calendar.component(.minute, from: reminderTime)

        for weekday in habit.frequency {
            var dateComponents = DateComponents()
            dateComponents.hour = hour
            dateComponents.minute = minute
            dateComponents.weekday = weekday == 7 ? 1 : weekday + 1

            let trigger = UNCalendarNotificationTrigger(
                dateMatching: dateComponents,
                repeats: true
            )

            let content = UNMutableNotificationContent()
            content.title = "\(habit.emoji) \(habit.name)"
            content.body = "Hora de manter seu hábito!"
            content.sound = .default

            let id = "habit-\(habit.id.uuidString)-day-\(weekday)"
            let request = UNNotificationRequest(
                identifier: id,
                content: content,
                trigger: trigger
            )

            UNUserNotificationCenter.current().add(request)
        }
    }

    func cancel(for habit: Habit) {
        let ids = habit.frequency.map {
            "habit-\(habit.id.uuidString)-day-\($0)"
        }
        UNUserNotificationCenter.current().removePendingNotificationRequests(
            withIdentifiers: ids
        )
    }
}
