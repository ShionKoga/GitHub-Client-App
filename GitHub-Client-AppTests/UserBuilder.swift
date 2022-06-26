import Foundation
@testable import GitHub_Client_App

class UserBuilder {
    private var userName: String = ""
    private var iconUrl: String = "https://example.com"
    
    func withUserName(newValue: String) -> Self {
        userName = newValue
        return self
    }
    
    func withIconUrl(newValue: String) -> Self {
        iconUrl = newValue
        return self
    }
    
    func build() -> User {
        return User(userName: userName, iconUrl: iconUrl)
    }
}
