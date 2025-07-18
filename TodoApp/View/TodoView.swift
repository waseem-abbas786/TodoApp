import SwiftUI

struct TodoView: View {
    @StateObject private var viewModel = TodoViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                } else {
                    List {
                        ForEach(viewModel.todos.prefix(20)) { todo in
                            HStack {
                                Image(systemName: todo.completed ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(todo.completed ? .green : .gray)
                                Text(todo.title)
                            }
                        }
                        .onDelete(perform: viewModel.deleteTodo)
                        .onMove(perform: viewModel.onMove)
                    }
                }

                HStack {
                    Button("Clear") {
                        viewModel.clearUserDefaults()
                    }
                }
                .padding()
                .buttonStyle(.bordered)
            }
            .navigationTitle("Todos")
            .navigationBarItems(leading: EditButton())
        }
        .task {
            await viewModel.fetchData()
        }
    }
}
