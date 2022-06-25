import Foundation
import BrightFutures

protocol UsersRepository {
    func searchUser(query: String) -> Future<[User], Error>
}

class GitHubUsersRepository: UsersRepository {
    let baseUrl: String = "https://api.github.com/search/users"
    let http: Http
    
    init(http: Http) {
        self.http = http
    }
    
    func searchUser(query: String) -> Future<[User], Error> {
        return http
            .get(urlString: baseUrl + "?q=" + query)
            .map { data in
                return try! JSONDecoder().decode(GitHubApiResponse.self, from: data).items
            }
    }
}
