import UIKit
import Quick
import Nimble
@testable import GitHub_Client_App

class UsersTableViewCellTests: QuickSpec {
    override func spec() {
        describe("UsersTableViewCell") {
            var usersTableViewCell: UsersTableViewCell!
            var spyStubUsersRepo: SpyStubUsersRepository!
            
            beforeEach {
                usersTableViewCell = UsersTableViewCell()
                spyStubUsersRepo = SpyStubUsersRepository()
                usersTableViewCell.repository = spyStubUsersRepo
            }
            
            it("desplays user name") {
                let user = User(userName: "user name")
                usersTableViewCell.configure(user: user)
                
                
                expect(usersTableViewCell.textLabel?.text).to(equal("user name"))
            }
            
            it("desplays icon image") {
                let user = User(userName: "")
                usersTableViewCell.configure(user: user)
                
                
                expect(usersTableViewCell.imageView?.image).toNot(beNil())
            }
        }
    }
}
