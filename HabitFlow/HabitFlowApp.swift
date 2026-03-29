import SwiftUI
import SwiftData

@main
struct HabitFlowApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Hoje", systemImage: "house.fill")
                    }

                StatsView()
                    .tabItem {
                        Label("Estatísticas", systemImage: "chart.bar.fill")
                    }
            }
            .tint(Color(hex: "#5E5CE6"))
        }
        .modelContainer(for: [Habit.self, HabitEntry.self])
    }
}
