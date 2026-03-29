import SwiftUI
import SwiftData

struct HabitFormView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = HabitFormViewModel()

    let habitToEdit: Habit?

    var body: some View {
        NavigationStack {
            Form {
                Section("Nome do hábito") {
                    TextField("Ex: Beber água", text: $viewModel.name)
                        .onChange(of: viewModel.name) {
                            if viewModel.name.count > 50 {
                                viewModel.name = String(viewModel.name.prefix(50))
                            }
                        }
                }

                Section("Emoji") {
                    EmojiPickerView(selected: $viewModel.emoji)
                }

                Section("Cor") {
                    ColorPickerView(selectedHex: $viewModel.colorHex)
                }

                Section("Dias da semana") {
                    WeekdayPickerView(selectedDays: $viewModel.frequency)
                }

                Section("Lembrete") {
                    ReminderPickerView(
                        enabled: $viewModel.reminderEnabled,
                        time: $viewModel.reminderTime
                    )
                }

                if viewModel.isEditing {
                    Section {
                        Button(role: .destructive) {
                            if let habit = habitToEdit {
                                NotificationService.shared.cancel(for: habit)
                                modelContext.delete(habit)
                                try? modelContext.save()
                            }
                            dismiss()
                        } label: {
                            HStack {
                                Spacer()
                                Label("Excluir hábito", systemImage: "trash")
                                Spacer()
                            }
                        }
                    }
                }
            }
            .navigationTitle(viewModel.isEditing ? "Editar Hábito" : "Novo Hábito")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar") {
                        viewModel.save(context: modelContext)
                        dismiss()
                    }
                    .disabled(!viewModel.isValid)
                }
            }
            .onAppear {
                if let habit = habitToEdit {
                    viewModel.configure(with: habit)
                }
            }
        }
    }
}
