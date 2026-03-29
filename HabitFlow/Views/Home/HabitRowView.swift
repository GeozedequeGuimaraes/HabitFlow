import SwiftUI

struct HabitRowView: View {
    let habit: Habit
    let onToggle: () -> Void

    var body: some View {
        HStack(spacing: 14) {
            Text(habit.emoji)
                .font(.title)

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(habit.name)
                        .font(.headline)

                    if habit.currentStreak > 0 {
                        Label("\(habit.currentStreak) dias", systemImage: "flame.fill")
                            .font(.caption)
                            .foregroundStyle(.orange)
                    }
                }

                Text(scheduledDaysText)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            ProgressRingView(
                progress: habit.completionRateThisWeek,
                isCompleted: habit.isCompletedToday,
                color: Color(hex: habit.colorHex)
            )
            .frame(width: 44, height: 44)
            .onTapGesture {
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()
                onToggle()
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.background)
                .shadow(color: .black.opacity(0.06), radius: 8, y: 2)
        )
        .padding(.horizontal)
        .padding(.vertical, 4)
    }

    private var scheduledDaysText: String {
        habit.frequency.sorted().map { Constants.weekdayNames[$0 - 1] }.joined(separator: " ")
    }
}
