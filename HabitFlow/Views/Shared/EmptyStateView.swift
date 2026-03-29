import SwiftUI

struct EmptyStateView: View {
    let onCreateTapped: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Image(systemName: "leaf.fill")
                .font(.system(size: 60))
                .foregroundStyle(.green.opacity(0.6))

            Text("Nenhum hábito para hoje")
                .font(.title3.bold())

            Text("Comece criando seu primeiro hábito\ne construa uma rotina incrível!")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            Button {
                onCreateTapped()
            } label: {
                Label("Criar primeiro hábito", systemImage: "plus")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(Color(hex: "#5E5CE6"))
                    .clipShape(Capsule())
            }

            Spacer()
        }
        .padding()
    }
}
