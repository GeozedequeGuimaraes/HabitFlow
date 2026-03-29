import SwiftUI
import Charts

struct StreakBarChartView: View {
    let data: [(day: Int, count: Int)]

    var body: some View {
        Chart(data, id: \.day) { item in
            BarMark(
                x: .value("Dia", item.day),
                y: .value("Concluídos", item.count)
            )
            .foregroundStyle(Color(hex: "#5E5CE6").gradient)
            .cornerRadius(3)
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: 5)) { value in
                AxisValueLabel()
                AxisGridLine()
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading)
        }
    }
}
