import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
 @State  var isAnimate : Bool = false

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
                .padding()
                .frame(width:150)
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
            } else {
                VStack (spacing: 25){
                    Spacer()
                    Text("Create Account")
                        .font(.headline)

                    TextField("Username", text: $viewModel.username)
                        .padding()
                        .frame(height: 55)
                        .frame(maxWidth: 380)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(.buttonBorder)
                        .shadow(color: Color.gray, radius: 70)

                    TextField("City", text: $viewModel.city)
                        .padding()
                        .frame(height: 55)
                        .frame(maxWidth: 380)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(.buttonBorder)
                        .shadow(color: Color.gray, radius: 70)

                    SecureField("Password", text: $viewModel.password)
                        .padding()
                        .frame(height: 55)
                        .frame(maxWidth: 380)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(.buttonBorder)
                        .shadow(color: Color.gray, radius: 70)
                    Spacer()

                    Button("Sign Up") {
                        withAnimation {
                            viewModel.signUp()
                            viewModel.password = ""
                            viewModel.username = ""
                            viewModel.city = ""
                        }
                      
                }
                    .padding()
                    .frame(width: 150)
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
//#Preview {
//    ProfileView()
//}
