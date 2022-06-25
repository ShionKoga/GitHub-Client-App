import Foundation

struct GitHubApiResponse: Codable {
    let items: [User]
    
    private enum CodingKeys: String, CodingKey {
        case items
    }
}
