import BrightFutures
import UIKit
@testable import GitHub_Client_App


class SpyStubUsersRepository: UsersRepository {
    private(set) var searchUser_returnValue = Promise<[User], Error>()
    private(set) var argument_searchUser_query: String? = nil
    private(set) var searchUser_wasCalled: Bool = false
    
    func searchUser(query: String) -> Future<[User], Error> {
        argument_searchUser_query = query
        searchUser_wasCalled = true
        return searchUser_returnValue.future
    }
    
    private(set) var getIcon_returnValue = Promise<UIImage, Error>()
    private(set) var argument_getIcon_urlString: String? = nil
    func getIcon(urlString: String) -> Future<UIImage, Error> {
        argument_getIcon_urlString = urlString
        return getIcon_returnValue.future
    }
}
