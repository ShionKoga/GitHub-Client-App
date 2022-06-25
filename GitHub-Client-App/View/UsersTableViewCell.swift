import UIKit


class UsersTableViewCell: UITableViewCell {
    var repository: UsersRepository = GitHubUsersRepository(http: NetworkHttp(networkSession: URLSession.shared))
    
    func configure(user: User) {
        imageView?.image = UIImage(color: .gray, size: CGSize(width: 20, height: 20))!
        textLabel?.text = user.userName
    }
}
