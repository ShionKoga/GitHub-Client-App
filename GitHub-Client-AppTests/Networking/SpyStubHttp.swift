import Foundation
import BrightFutures
@testable import GitHub_Client_App

class SpyStubHttp: Http {
    private(set) var get_returnValue = Promise<Data, Error>()
    private(set) var get_argument_urlString: String? = nil
    
    func get(urlString: String) -> Future<Data, Error> {
        get_argument_urlString = urlString
        return get_returnValue.future
    }
}
