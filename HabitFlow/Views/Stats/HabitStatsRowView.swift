import SwiftUI

struct HabitStatsRowView: View {
    let stat: HabitStatData

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("\(stat.habit.emoji) \(stat.habit.name)")
                    .font(.subheadline.bold())
                Spacer()
                Text("\(Int(stat.rate * 100))%")
                    .font(.subheadline.bold())
                    .foregroundStyle(Color(hex: stat.habit.colorHex))
                Text("\(stat.completedDays)/\(stat.scheduledDays)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color(hex: stat.habit.colorHex).opacity(0.2))

                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color(hex: stat.habit.colorHex))
                        .frame(width: geo.size.width * stat.rate)
                        .animation(.easeInOut, value: stat.rate)
                }
            }
            .frame(height: 10)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.background)
                .shadow(color: .black.opacity(0.06), radius: 6, y: 2)
        )
        .padding(.horizontal)
    }
}
