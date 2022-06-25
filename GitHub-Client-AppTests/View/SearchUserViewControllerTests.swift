import Quick
import Nimble

@testable import GitHub_Client_App
import UIKit

class SearchUserViewControllerTests: QuickSpec {
    override func spec() {
        describe("SearchUserViewController") {
            var searchUserVC: SearchUserViewController!
            var spyStubPresenter: SpyStubSearchUserPresenter!
            
            beforeEach {
                spyStubPresenter = SpyStubSearchUserPresenter()
                searchUserVC = SearchUserViewController(presenter: spyStubPresenter)
                searchUserVC.loadViewIfNeeded()
            }
            
            it("displays searchBar on navigationItem titleView") {
                let searchBar = searchUserVC.navigationItem.titleView as? UISearchBar
                
                expect(searchBar).toNot(beNil())
            }
            
            it("placeholder of searchBar to be ユーザーを検索") {
                let searchBar = searchUserVC.navigationItem.titleView as? UISearchBar
                
                expect(searchBar?.placeholder).to(equal("ユーザーを検索"))
            }
            
            it("call and passes correct argument when submit search bar") {
                let searchBar = searchUserVC.navigationItem.titleView as! UISearchBar
                
                
                searchBar.text = "a"
                searchBar.delegate?.searchBarSearchButtonClicked?(searchBar.self)
                
                
                expect(spyStubPresenter.didTapSearchButton_argument_text).to(equal("a"))
            }
            
            it("displays user names on tableView") {
                spyStubPresenter.users = [
                    User(userName: "userA", iconUrl: ""),
                    User(userName: "userB", iconUrl: ""),
                ]
                
                let tableView = searchUserVC.usersTableView!
                let numberOfRows = tableView.dataSource?.tableView(
                    tableView,
                    numberOfRowsInSection: 0
                )
                let labelTexts = (0...1).compactMap { row in
                    return tableView.dataSource?
                        .tableView(tableView, cellForRowAt: IndexPath(row: row, section: 0))
                        .textLabel?.text
                }
            
                expect(numberOfRows).to(equal(2))
                expect(labelTexts).toEventually(contain("userA"))
                expect(labelTexts).toEventually(contain("userB"))
            }
            
            it("passes tableView to presenter") {
                expect(spyStubPresenter.reloadable).to(beAKindOf(UITableView.self))
            }
        }
    }
}
