import SwiftUI

struct ProgressRingView: View {
    let progress: Double
    let isCompleted: Bool
    let color: Color

    var body: some View {
        ZStack {
            Circle()
                .stroke(color.opacity(0.2), lineWidth: 4)

            Circle()
                .trim(from: 0, to: progress)
                .stroke(color, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 0.3), value: progress)

            Image(systemName: isCompleted ? "checkmark" : "circle")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(isCompleted ? color : .secondary)
                .contentTransition(.symbolEffect(.replace))
        }
    }
}
