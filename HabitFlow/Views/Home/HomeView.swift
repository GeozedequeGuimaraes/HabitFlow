import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Habit.createdAt) private var allHabits: [Habit]
    @State private var viewModel = HabitListViewModel()

    private var todaysHabits: [Habit] {
        allHabits.filter(\.isScheduledForToday)
    }

    private var completedCount: Int {
        todaysHabits.filter(\.isCompletedToday).count
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                if todaysHabits.isEmpty {
                    EmptyStateView {
                        viewModel.showingForm = true
                    }
                } else {
                    List {
                        Section {
                            Text("\(completedCount) de \(todaysHabits.count) hábitos concluídos")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .listRowSeparator(.hidden)
                        }

                        ForEach(todaysHabits, id: \.id) { habit in
                            HabitRowView(habit: habit) {
                                withAnimation(.spring(response: 0.3)) {
                                    viewModel.toggleCompletion(for: habit, context: modelContext)
                                }
                            }
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
                            .contextMenu {
                                Button {
                                    viewModel.habitToEdit = habit
                                    viewModel.showingForm = true
                                } label: {
                                    Label("Editar", systemImage: "pencil")
                                }
                                Button(role: .destructive) {
                                    viewModel.deleteHabit(habit, context: modelContext)
                                } label: {
                                    Label("Excluir", systemImage: "trash")
                                }
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button(role: .destructive) {
                                    viewModel.deleteHabit(habit, context: modelContext)
                                } label: {
                                    Label("Excluir", systemImage: "trash")
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                    .contentMargins(.bottom, 80)
                }

                Button {
                    viewModel.habitToEdit = nil
                    viewModel.showingForm = true
                } label: {
                    Image(systemName: "plus")
                        .font(.title2.bold())
                        .foregroundStyle(.white)
                        .frame(width: 56, height: 56)
                        .background(Color(hex: "#5E5CE6"))
                        .clipShape(Circle())
                        .shadow(color: Color(hex: "#5E5CE6").opacity(0.4), radius: 8, y: 4)
                }
                .padding(.trailing, 20)
                .padding(.bottom, 20)
            }
            .navigationTitle("Hoje, \(Date().formattedWeekday())")
            .sheet(isPresented: $viewModel.showingForm) {
                HabitFormView(habitToEdit: viewModel.habitToEdit)
            }
            .task {
                await NotificationService.shared.requestAuthorization()
            }
            .onChange(of: allHabits.map(\.isCompletedToday)) {
                WidgetDataService.update(habits: allHabits)
            }
            .onAppear {
                WidgetDataService.update(habits: allHabits)
            }
        }
    }
}
