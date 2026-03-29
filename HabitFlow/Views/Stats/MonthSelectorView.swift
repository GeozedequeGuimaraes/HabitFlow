import SwiftUI

struct MonthSelectorView: View {
    let month: Date
    let canGoForward: Bool
    let onPrevious: () -> Void
    let onNext: () -> Void

    var body: some View {
        HStack {
            Button(action: onPrevious) {
                Image(systemName: "chevron.left")
                    .font(.title3.bold())
            }

            Spacer()

            Text(month.formattedMonthYear())
                .font(.title3.bold())

            Spacer()

            Button(action: onNext) {
                Image(systemName: "chevron.right")
                    .font(.title3.bold())
            }
            .disabled(!canGoForward)
            .opacity(canGoForward ? 1 : 0.3)
        }
        .padding(.horizontal)
    }
}
