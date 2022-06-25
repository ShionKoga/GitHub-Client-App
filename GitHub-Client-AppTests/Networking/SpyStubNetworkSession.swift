import Foundation
@testable import GitHub_Client_App

class SpyStubNetworkSession: NetworkSession {
    private(set) var argument_dataTask_request: URLRequest? = nil
    var dataTask_completionHandler_inputs: Data? = nil
    var dataTask_returnValue: SpySessionDataTask = SpySessionDataTask()
    
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        argument_dataTask_request = request
        completionHandler(dataTask_completionHandler_inputs, nil, nil)
        return dataTask_returnValue
    }
}
