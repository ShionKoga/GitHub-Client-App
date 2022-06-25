import Foundation
import Quick
import Nimble
import BrightFutures
@testable import GitHub_Client_App


class UserRepositoryTests: QuickSpec {
    override func spec() {
        describe("UsersRepository") {
            var gitHubUsersRepo: GitHubUsersRepository!
            var spyStubHttp: SpyStubHttp!
            
            beforeEach {
                spyStubHttp = SpyStubHttp()
                gitHubUsersRepo = GitHubUsersRepository(http: spyStubHttp)
            }
            
            it("searchUser returns http.get return value ") {
                var users = [User]()
                AsyncExpectation.execute() { expectation in
                    let jsonResponse = """
                       {
                            "items":[
                                {"login": "userA", "avatar_url": "iconUrlA"},
                                {"login": "userB", "avatar_url": "iconUrlB"},
                            ]
                       }
                       """
                    spyStubHttp.get_returnValue.success(jsonResponse.data(using: .utf8)!)

                    gitHubUsersRepo
                        .searchUser(query: "")
                        .onSuccess { returnedUsers in
                        users = returnedUsers
                        expectation.fulfill()
                    }
                }
                
                
                expect(users.count).to(equal(2))
                expect(users.first?.userName).to(equal("userA"))
                expect(users.first?.iconUrl).to(equal("iconUrlA"))
                expect(users.last?.userName).to(equal("userB"))
                expect(users.last?.iconUrl).to(equal("iconUrlB"))
            }
            
            it("searchUser passes correct argument to http") {
                let _ = gitHubUsersRepo.searchUser(query: "search word")
                
                
                let expectUrlString = "https://api.github.com/search/users?q=search word"
                expect(spyStubHttp.get_argument_urlString).to(equal(expectUrlString))
            }
        }
    }
}
