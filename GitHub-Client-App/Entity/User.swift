import Foundation

struct User: Codable, Equatable {
    let userName: String

    private enum CodingKeys: String, CodingKey {
        case userName = "login"
    }
}
