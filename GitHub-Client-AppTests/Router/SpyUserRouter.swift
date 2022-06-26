import Foundation
@testable import GitHub_Client_App

class SpySearchUserRouter: SearchUserRouter {
    private(set) var argument_transitionToUserRepositories: String? = nil
    func transitionToUserRepositories(userName: String) {
        argument_transitionToUserRepositories = userName
    }
}
