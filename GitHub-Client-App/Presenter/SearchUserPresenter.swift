import Foundation

protocol SearchUserPresenter {
    var reloadable: Reloadable? { get set }
    var numberOfUsers: Int { get }
    func user(forRow row: Int) -> User?
    func didTapSearchButton(text: String?)
    func didTapRow(at indexPath: IndexPath)
}

class DefaultSearchUserPresenter: SearchUserPresenter {
    
    var users: [User] = []
    let usersRepository: UsersRepository
    var reloadable: Reloadable? = nil
    
    init(repository: UsersRepository) {
        self.usersRepository = repository
    }
    
    var numberOfUsers: Int {
        return users.count
    }
    
    func user(forRow row: Int) -> User? {
        guard row < users.count else { return nil }
        return users[row]
    }
    
    func didTapSearchButton(text: String?) {
        guard let query = text else { return }
        if query.isEmpty { return }
        
        usersRepository
            .searchUser(query: query)
            .onSuccess { users in
                self.users = users
                self.reloadable?.reloadData()
            }
    }
    
    func didTapRow(at indexPath: IndexPath) {
        
    }
}
