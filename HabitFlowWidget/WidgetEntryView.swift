import SwiftUI
import WidgetKit

struct WidgetEntryView: View {
    @Environment(\.widgetFamily) var family
    var entry: HabitWidgetEntry

    var body: some View {
        switch family {
        case .systemSmall:
            smallWidget
        case .systemMedium:
            mediumWidget
        default:
            smallWidget
        }
    }

    // MARK: - Small Widget

    private var smallWidget: some View {
        VStack(spacing: 8) {
            Text("HabitFlow")
                .font(.caption2.bold())
                .foregroundStyle(.secondary)

            if entry.totalCount == 0 {
                Text("Nenhum hábito hoje")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            } else {
                Text("\(entry.completedCount)/\(entry.totalCount)")
                    .font(.system(size: 34, weight: .bold, design: .rounded))

                Text("hoje")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                ProgressView(value: Double(entry.completedCount), total: Double(entry.totalCount))
                    .tint(Color(hex: "#5E5CE6"))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: - Medium Widget

    private var mediumWidget: some View {
        HStack(spacing: 0) {
            // Left side - summary
            VStack(alignment: .leading, spacing: 4) {
                Text("HabitFlow")
                    .font(.caption2.bold())
                    .foregroundStyle(.secondary)

                Spacer()

                Text("\(entry.completedCount)/\(entry.totalCount)")
                    .font(.system(size: 28, weight: .bold, design: .rounded))

                Text("Hoje")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .frame(maxHeight: .infinity)
            .padding(.trailing, 12)

            Divider()
                .padding(.vertical, 4)

            // Right side - habit list
            VStack(alignment: .leading, spacing: 6) {
                ForEach(entry.habits.prefix(4)) { habit in
                    HStack(spacing: 6) {
                        Image(systemName: habit.isCompleted ? "checkmark.circle.fill" : "circle")
                            .font(.caption)
                            .foregroundStyle(habit.isCompleted ? Color(hex: habit.colorHex) : .secondary)

                        Text("\(habit.emoji) \(habit.name)")
                            .font(.caption)
                            .lineLimit(1)

                        Spacer()
                    }
                }

                if entry.habits.count > 4 {
                    Text("+\(entry.habits.count - 4) mais")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.leading, 12)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// Color extension for Widget target
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = Double(rgbValue & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}
