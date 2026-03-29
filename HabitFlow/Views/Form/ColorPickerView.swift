import SwiftUI

struct ColorPickerView: View {
    @Binding var selectedHex: String

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 6)

    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(Constants.habitColors, id: \.self) { hex in
                Circle()
                    .fill(Color(hex: hex))
                    .frame(width: 36, height: 36)
                    .overlay(
                        Circle()
                            .stroke(Color.primary, lineWidth: selectedHex == hex ? 3 : 0)
                            .padding(2)
                    )
                    .onTapGesture {
                        selectedHex = hex
                    }
            }
        }
    }
}
