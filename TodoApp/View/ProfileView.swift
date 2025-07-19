import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
 @State  var isAnimate : Bool = false

    var body: some View {
        ZStack {
            Color.gray.opacity(0.1).ignoresSafeArea()
            VStack(spacing: 20) {
                if let user = viewModel.currentUser {
                    Text("👋 Welcome, \(user.userName)")
                        .font(.title)

                    Text("🌆 City: \(user.city)")
                        .foregroundStyle(.secondary)

                    Button("Log out") {
                        viewModel.logout()
                    }
                    .padding()
                    .frame(width:isAnimate ? 150 : 200)
                    .foregroundStyle(Color.white)
                    .background(Color.blue)
                    .clipShape(.buttonBorder)
                    .onAppear {
                            withAnimation(
                            .easeInOut(duration: 4.0).repeatForever(autoreverses: true))
                                    {
                                            isAnimate = true
                                        }
                                    }
                } else {
                    VStack (spacing: 25){
                        Spacer()
                        Text("Create Account")
                            .font(.headline)

                        TextField("Username", text: $viewModel.username)
                            .padding()
                            .frame(height: 55)
                            .frame(maxWidth: 380)
                            .background(Color.white)
                            .clipShape(.buttonBorder)

                        TextField("City", text: $viewModel.city)
                            .padding()
                            .frame(height: 55)
                            .frame(maxWidth: 380)
                            .background(Color.white)
                            .clipShape(.buttonBorder)

                        SecureField("Password", text: $viewModel.password)
                            .padding()
                            .frame(height: 55)
                            .frame(maxWidth: 380)
                            .background(Color.white)
                            .clipShape(.buttonBorder)
                        Spacer()

                        Button("Sign Up") {
                                viewModel.signUp()
                                viewModel.password = ""
                                viewModel.username = ""
                                viewModel.city = ""
                    }
                        .padding()
                        .frame(width:isAnimate ? 150 : 200)
                        .foregroundStyle( Color.white)
                        .background(Color.blue)
                        .clipShape(.buttonBorder)
                        .onAppear {
                                withAnimation(
                                .easeInOut(duration: 4.0).repeatForever(autoreverses: true))
                                        {
                                            isAnimate.toggle()
                                            }
                                        }
                        Spacer()

                    }
                    
                    

                    if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                    }
                }
            }
            Spacer()
            .padding()
            .onAppear {
                viewModel.loadUser()
            }
        }
    
    }
}
#Preview {
    ProfileView()
}
