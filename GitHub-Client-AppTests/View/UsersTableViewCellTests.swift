import UIKit
import Quick
import Nimble
import BrightFutures
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
                let user = UserBuilder().withUserName(newValue: "user name").build()
                usersTableViewCell.configure(user: user)
                
                
                expect(usersTableViewCell.textLabel?.text).to(equal("user name"))
            }
            
            it("desplays icon image") {
                let user = UserBuilder().build()
                usersTableViewCell.configure(user: user)
                
                
                expect(usersTableViewCell.imageView?.image).toNot(beNil())
            }
            
            it("passes icon url to repository.getIcon") {
                let user = UserBuilder().withIconUrl(newValue: "https://example.com/icon").build()
                usersTableViewCell.configure(user: user)
                
                
                expect(spyStubUsersRepo.argument_getIcon_urlString).to(equal("https://example.com/icon"))
            }
            
            it("updates iconImage when repository returns image") {
                let expectedImage = UIImage()
                spyStubUsersRepo.getIcon_returnValue.success(expectedImage)
                
                
                let user = UserBuilder().build()
                usersTableViewCell.configure(user: user)
                
                
                expect(usersTableViewCell.imageView?.image).toEventually(equal(expectedImage))
            }
        }
    }
}
