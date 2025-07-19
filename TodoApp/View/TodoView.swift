import SwiftUI

struct TodoView: View {
    @ObservedObject var viewModel = TodoViewModel()
    @State var isAnimate: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.opacity(0.1).ignoresSafeArea()
                Group {
                    if viewModel.todos.isEmpty {
                        VStack(spacing: 20) {
                            Spacer()
                            
                            Text("“Your future is created by what you do today, not tomorrow.”")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)

                            NavigationLink(destination: AddItem(viewModel: viewModel)) {
                                Text("Add Your First Todo")
                                    .fontWeight(.bold)
                                    .padding()
                                    .frame(width: isAnimate ? 200 : 300)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                                    .padding(.horizontal)
                                    .onAppear {
                                        withAnimation(.easeInOut(duration: 3.0).repeatForever()){
                                            isAnimate.toggle()
                                        }
                                    }
                            }
                           
                            
                            Spacer()
                        }
                    } else {
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
                                        .onTapGesture {
                                            viewModel.toggleCompletion(for: todo)
                                        }
                                    }
                                    .onDelete(perform: viewModel.deleteTodo)
                                    .onMove(perform: viewModel.onMove)
                                }
                                .listStyle(.insetGrouped)

                                Button("Clear All Todos") {
                                    viewModel.clearUserDefaults()
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(isAnimate ? Color.gray.opacity(0.01) : Color.gray.opacity(0.5))
                                .foregroundColor(isAnimate ? Color.blue : Color.white)
                                .clipShape(.buttonBorder)
                                .padding(.horizontal)
                                .onAppear {
                                    withAnimation(.easeInOut(duration: 4.0).repeatForever(autoreverses: true)) {
                                        isAnimate = true
                                    }
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Todos")
                .navigationBarItems(
                    leading: viewModel.todos.isEmpty ? nil : EditButton(),
                    trailing: NavigationLink("Add", destination: AddItem(viewModel: viewModel))
                )
            }
            }
           
        .task {
            await viewModel.fetchData()
        }
    }
}

#Preview {
    TodoView()
}
