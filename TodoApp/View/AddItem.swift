import SwiftUI

struct AddItem: View {
    @ObservedObject var viewModel: TodoViewModel
    @State private var errorMessage: String?
    @State private var isAnimate : Bool = false
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1).ignoresSafeArea()
            VStack(spacing: 30) {
                TextField("Add Item", text: $viewModel.newItem)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(Color.red)
                        .font(.caption)
                }
                Button("SAVE") {
                    if viewModel.newItem.count < 5 {
                        errorMessage = "Todo must Contain 5 Characters"
                    } else {
                        viewModel.addItem(title: viewModel.newItem)
                        viewModel.newItem = ""
                        errorMessage = nil
                        presentationMode.wrappedValue.dismiss()
                    }
                    
                }
                .padding()
                .frame(width: isAnimate ? 150 : 200)
                .foregroundStyle(.white)
                .background(Color.blue)
                .cornerRadius(10)
                
            
            }
        }
    
        .navigationTitle("AddItem➕")
    }
}

#Preview {
    NavigationView {
        AddItem(viewModel: TodoViewModel())
    }
}
