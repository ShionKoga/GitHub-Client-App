import Foundation
import Quick
import Nimble
import BrightFutures

@testable import GitHub_Client_App

class SearchUserPresenterTests: QuickSpec {
    override func spec() {
        describe("SearchUserPresenter") {
            var searchUserPresenter: DefaultSearchUserPresenter!
            var spyStubUsersRepository: SpyStubUsersRepository!
            
            beforeEach {
                spyStubUsersRepository = SpyStubUsersRepository()
                searchUserPresenter = DefaultSearchUserPresenter(repository: spyStubUsersRepository)
            }
            
            it("numberOfUsers returns users count") {
                searchUserPresenter.users = [
                    UserBuilder().build(),
                    UserBuilder().build(),
                ]
                
                expect(searchUserPresenter.numberOfUsers).to(equal(2))
            }
            
            it("userForRow returns Specified User") {
                searchUserPresenter.users = [
                    UserBuilder().withUserName(newValue: "userA").build(),
                    UserBuilder().withUserName(newValue: "userB").build(),
                ]
                
                expect(searchUserPresenter.user(forRow: 0)?.userName).to(equal("userA"))
            }
            
            it("userForRow returns nil when passing a value greater than users count") {
                searchUserPresenter.users = []
                
                expect(searchUserPresenter.user(forRow: 1)).to(beNil())
            }
            
            it("hold usersRepository return value") {
                let expectedUsers = [
                    UserBuilder().withUserName(newValue: "user name").build()
                ]
                spyStubUsersRepository.searchUser_returnValue.success(expectedUsers)
                
                
                searchUserPresenter.didTapSearchButton(text: "hoge")
                
                
                expect(searchUserPresenter.users).toEventually(equal(expectedUsers))
            }
            
            it("didTapSearchButton call and passes argument to usersRepository") {
                searchUserPresenter.didTapSearchButton(text: "user name")
                
                
                expect(spyStubUsersRepository.searchUser_wasCalled).to(beTrue())
                expect(spyStubUsersRepository.argument_searchUser_query).to(equal("user name"))
            }
            
            it("didTapSearchButton do not call usersRepository.searchUser when passing nil as argument") {
                searchUserPresenter.didTapSearchButton(text: nil)
                
                
                expect(spyStubUsersRepository.searchUser_wasCalled).to(beFalse())
            }
            
            it("didTapSearchButton do not call usersRepository.searchUser when passing empty string as argument") {
                searchUserPresenter.didTapSearchButton(text: "")
                
                
                expect(spyStubUsersRepository.searchUser_wasCalled).to(beFalse())
            }
            
            it("calls reloadable.reloadData when success") {
                let spyReloadable = SpyReloadable()
                searchUserPresenter.reloadable = spyReloadable
                spyStubUsersRepository.searchUser_returnValue.success([])
                
                searchUserPresenter.didTapSearchButton(text: "hoge")
                
                expect(spyReloadable.reloadData_wasCalled).toEventually(beTrue())
            }
        }
    }
}
