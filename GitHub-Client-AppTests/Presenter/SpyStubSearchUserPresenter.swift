import Foundation
@testable import GitHub_Client_App

class SpyStubSearchUserPresenter: SearchUserPresenter {
    var reloadable: Reloadable?
    var users: [User] = []
    
    var numberOfUsers: Int {
        return users.count
    }
    
    func user(forRow row: Int) -> User? {
        guard row < users.count else { return nil }
        return users[row]
    }
    
    private(set) var didTapSearchButton_argument_text: String? = nil
    func didTapSearchButton(text: String?) {
        didTapSearchButton_argument_text = text
    }
}
