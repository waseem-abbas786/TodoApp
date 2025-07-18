import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var username = ""
    @Published var city = ""
    @Published var password = ""
    @Published var errorMessage: String?
    @Published var currentUser: User?

    private let userKey = "LoggedInUser"

    func signUp() {
        let newUser = User(userName: username, password: password, city: city)

        guard newUser.isValid else {
            errorMessage = "Username must be >6 characters and contain a capital letter"
            return
        }

        currentUser = newUser
        saveUserToDefaults(user: newUser)
        errorMessage = nil
    }

    private func saveUserToDefaults(user: User) {
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: userKey)
        }
    }

    func loadUser() {
        if let data = UserDefaults.standard.data(forKey: userKey),
           let decoded = try? JSONDecoder().decode(User.self, from: data) {
            currentUser = decoded
        }
    }

    func logout() {
        UserDefaults.standard.removeObject(forKey: userKey)
        currentUser = nil
    }
}
