import SwiftUI
import SwiftData
import Charts

struct StatsView: View {
    @Query(sort: \Habit.createdAt) private var habits: [Habit]
    @State private var viewModel = StatsViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    MonthSelectorView(
                        month: viewModel.selectedMonth,
                        canGoForward: viewModel.canGoForward,
                        onPrevious: viewModel.goToPreviousMonth,
                        onNext: viewModel.goToNextMonth
                    )

                    // Summary cards
                    HStack(spacing: 12) {
                        StatCard(
                            title: "Melhor streak",
                            value: "\(viewModel.bestStreak(habits: habits)) dias"
                        )
                        StatCard(
                            title: "Média conclus.",
                            value: "\(Int(viewModel.averageRate(habits: habits) * 100))%"
                        )
                        StatCard(
                            title: "Total concluíd.",
                            value: "\(viewModel.totalCompleted(habits: habits))"
                        )
                    }
                    .padding(.horizontal)

                    // Bar chart
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Conclusões por dia")
                            .font(.headline)
                            .padding(.horizontal)

                        StreakBarChartView(
                            data: viewModel.completionsPerDay(habits: habits)
                        )
                        .frame(height: 200)
                        .padding(.horizontal)
                    }

                    // Per-habit stats
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Por hábito")
                            .font(.headline)
                            .padding(.horizontal)

                        ForEach(viewModel.habitStats(habits: habits)) { stat in
                            HabitStatsRowView(stat: stat)
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Estatísticas")
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String

    var body: some View {
        VStack(spacing: 6) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(value)
                .font(.title3.bold())
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.background)
                .shadow(color: .black.opacity(0.06), radius: 6, y: 2)
        )
    }
}
