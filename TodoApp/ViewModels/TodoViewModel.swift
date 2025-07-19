import Foundation

@MainActor
class TodoViewModel: ObservableObject {
    @Published var newItem: String = ""
    @Published var todos: [Todo] = [] {
        didSet {
            saveToUserDefaults()
        }
    }
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    let key = "1234"

    init() {
        loadFromUserDefaults()
    }

    func fetchData() async {
        isLoading = true
        errorMessage = nil

        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else {
            isLoading = false
            errorMessage = "Invalid URL"
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode([Todo].self, from: data)
            todos = decoded
        } catch {
            errorMessage = "Failed To Load Data ⚠️"
        }

        isLoading = false
    }

    private func saveToUserDefaults() {
        do {
            let encoded = try JSONEncoder().encode(todos)
            UserDefaults.standard.set(encoded, forKey: key)
        } catch {
            print("Save Error: \(error)")
        }
    }

    private func loadFromUserDefaults() {
        guard let data = UserDefaults.standard.data(forKey: key) else { return }
        do {
            todos = try JSONDecoder().decode([Todo].self, from: data)
        } catch {
            print("Load Error: \(error)")
        }
    }

    func clearUserDefaults() {
        UserDefaults.standard.removeObject(forKey: key)
        todos = []
    }

    func deleteTodo(at offsets: IndexSet) {
        todos.remove(atOffsets: offsets)
    }

    func onMove(from source: IndexSet, to destination: Int) {
        DispatchQueue.main.async {
            self.todos.move(fromOffsets: source, toOffset: destination)
        }
    }

    func addItem(title: String) {
        let newid = (todos.last?.id ?? 0) + 1
        let newItem = Todo(id: newid, title: title, completed: false)
        todos.append(newItem)
    }
    func toggleCompletion (for todo : Todo) {
        if let index = todos.firstIndex(where: {$0.id == todo.id}) {
            todos[index].completed.toggle()
        }
    }
}
