import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    var isAnimate : Bool = false

    var body: some View {
        VStack(spacing: 20) {
            if let user = viewModel.currentUser {
                Text("👋 Welcome, \(user.userName)")
                    .font(.title)

                Text("🌆 City: \(user.city)")
                    .foregroundStyle(.secondary)

                Button("Log out") {
                    viewModel.logout()
                }
                .buttonStyle(.borderedProminent)
            } else {
                Text("Create Account")
                    .font(.headline)

                TextField("Username", text: $viewModel.username)
                    .textFieldStyle(.roundedBorder)

                TextField("City", text: $viewModel.city)
                    .textFieldStyle(.roundedBorder)

                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(.roundedBorder)

                Button("Sign Up") {
                    viewModel.signUp()
                    viewModel.password = ""
                    viewModel.username = ""
                    viewModel.city = ""
                }
                .buttonStyle(.borderedProminent)

                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.loadUser()
        }
    }
}
