import SwiftUI

struct WeekdayPickerView: View {
    @Binding var selectedDays: Set<Int>

    var body: some View {
        HStack(spacing: 8) {
            ForEach(1...7, id: \.self) { day in
                let isSelected = selectedDays.contains(day)
                Text(Constants.weekdayNames[day - 1])
                    .font(.caption.bold())
                    .frame(width: 40, height: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(isSelected ? Color.accentColor : Color(.systemGray5))
                    )
                    .foregroundStyle(isSelected ? .white : .primary)
                    .onTapGesture {
                        if isSelected && selectedDays.count > 1 {
                            selectedDays.remove(day)
                        } else if !isSelected {
                            selectedDays.insert(day)
                        }
                    }
            }
        }
    }
}
