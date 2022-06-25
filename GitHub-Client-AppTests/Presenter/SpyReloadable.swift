import Foundation
@testable import GitHub_Client_App


class SpyReloadable: Reloadable {
    private(set) var reloadData_wasCalled: Bool = false
    func reloadData() {
        reloadData_wasCalled = true
    }
}
