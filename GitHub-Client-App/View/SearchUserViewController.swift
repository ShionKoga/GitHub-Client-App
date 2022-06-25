import UIKit

class SearchUserViewController: UIViewController {
    var searchBar: UISearchBar!
    var usersTableView: UITableView!
    private var searchUserPresenter: SearchUserPresenter
    
    init(presenter: SearchUserPresenter) {
        self.searchUserPresenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSearchBar()
        setupTableView()
        searchUserPresenter.reloadable = usersTableView
    }
    
    private func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
        searchBar.placeholder = "ユーザーを検索"
        navigationItem.titleView = searchBar
    }
    
    private func setupTableView() {
        usersTableView = UITableView(frame: view.frame)
        usersTableView.dataSource = self
        usersTableView.register(
            UsersTableViewCell.self,
            forCellReuseIdentifier: String(describing: UsersTableViewCell.self)
        )
        view.addSubview(usersTableView)
    }
}

extension SearchUserViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchUserPresenter.didTapSearchButton(text: searchBar.text)
    }
}

extension SearchUserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchUserPresenter.numberOfUsers
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: UsersTableViewCell.self),
                for: indexPath
            ) as? UsersTableViewCell
        else {
            return UITableViewCell()
        }
        
        guard let userName = searchUserPresenter.user(forRow: indexPath.row)?.userName else { return cell }
        cell.configure(userName: userName)
        return cell
    }
}
