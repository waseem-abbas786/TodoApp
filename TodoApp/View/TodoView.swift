import SwiftUI

struct TodoView: View {
    @StateObject private var viewModel = TodoViewModel()
    @State var isAnimate : Bool = false

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
                    .listStyle(.insetGrouped)
                }

                HStack {
                    Button("Clear") {
                        viewModel.clearUserDefaults()
                    }
                    .padding()
                    .frame(width: 300)
                    .foregroundStyle(isAnimate ? Color.blue : Color.white)
                    .background(isAnimate ? Color.gray.opacity(0.01) : Color.gray.opacity(0.5))
                    .clipShape(.buttonBorder)
                    .onAppear {
                            withAnimation(
                            .easeInOut(duration: 4.0).repeatForever(autoreverses: true))
                                    {
                                            isAnimate = true
                                        }
                                    }
                }
            }
            .navigationTitle("Todos")
            .navigationBarItems(leading: EditButton())
        }
        .task {
            await viewModel.fetchData()
        }
    }
}
//#Preview {
//    TodoView()
//}
