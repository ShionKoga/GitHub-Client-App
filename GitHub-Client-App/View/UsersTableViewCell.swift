import UIKit



class UsersTableViewCell: UITableViewCell {
    func configure(userName: String) {
        textLabel?.text = userName
    }
}
