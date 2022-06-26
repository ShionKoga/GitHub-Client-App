import UIKit


protocol SearchUserRouter {
    func transitionToUserRepositories(userName: String)
}


class DefaultSearchUserRouter: SearchUserRouter {
    func transitionToUserRepositories(userName: String) {
        
    }
}
