
import Foundation
 
struct User: Identifiable, Codable {
    let id = UUID()
    var userName : String
    var password : String
    var city : String
    var isValid : Bool {
        userName.count > 6
    }
}
