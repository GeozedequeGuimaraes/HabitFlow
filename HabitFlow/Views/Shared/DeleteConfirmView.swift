import SwiftUI

struct DeleteConfirmView: View {
    let habitName: String
    let onConfirm: () -> Void
    let onCancel: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "trash.fill")
                .font(.largeTitle)
                .foregroundStyle(.red)

            Text("Excluir \"\(habitName)\"?")
                .font(.headline)

            Text("Esta ação não pode ser desfeita.\nTodos os registros serão perdidos.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            HStack(spacing: 16) {
                Button("Cancelar") {
                    onCancel()
                }
                .buttonStyle(.bordered)

                Button("Excluir") {
                    onConfirm()
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
            }
        }
        .padding(24)
    }
}
