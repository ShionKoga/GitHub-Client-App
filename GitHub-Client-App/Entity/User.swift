import Foundation

struct User: Codable, Equatable {
    let userName: String
    let iconUrl: String

    private enum CodingKeys: String, CodingKey {
        case userName = "login"
        case iconUrl = "avatar_url"
    }
}
