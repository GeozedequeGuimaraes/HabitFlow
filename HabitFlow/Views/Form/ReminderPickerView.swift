import SwiftUI

struct ReminderPickerView: View {
    @Binding var enabled: Bool
    @Binding var time: Date

    var body: some View {
        Toggle("Lembrete diário", isOn: $enabled)

        if enabled {
            DatePicker(
                "Horário",
                selection: $time,
                displayedComponents: .hourAndMinute
            )
        }
    }
}
