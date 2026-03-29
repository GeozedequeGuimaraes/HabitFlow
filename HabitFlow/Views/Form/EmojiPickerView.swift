import SwiftUI

struct EmojiPickerView: View {
    @Binding var selected: String

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 8)

    var body: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(Constants.defaultEmojis, id: \.self) { emoji in
                Text(emoji)
                    .font(.title2)
                    .frame(width: 40, height: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(selected == emoji ? Color.accentColor.opacity(0.2) : Color.clear)
                    )
                    .onTapGesture {
                        selected = emoji
                    }
            }
        }
    }
}
