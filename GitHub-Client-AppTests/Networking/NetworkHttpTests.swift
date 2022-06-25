import Quick
import Nimble
import BrightFutures
import Foundation
@testable import GitHub_Client_App


class NetworkHttpTests: QuickSpec {
    override func spec() {
        describe("NetworkHttp") {
            var spyStubNetworkSession: SpyStubNetworkSession!
            var networkHttp: NetworkHttp!
            
            beforeEach {
                spyStubNetworkSession = SpyStubNetworkSession()
                networkHttp = NetworkHttp(networkSession: spyStubNetworkSession)
            }
            
            it("makes request to correct url") {
                let _ = networkHttp.get(urlString: "http://www.example.com")
                
                
                let actualUrlString = spyStubNetworkSession.argument_dataTask_request?.url?.absoluteString
                expect(actualUrlString).to(equal("http://www.example.com"))
            }
            
            it("calls task.resume()") {
                let spySessionDataTask = SpySessionDataTask()
                spyStubNetworkSession.dataTask_returnValue = spySessionDataTask
                
                
                let _ = networkHttp.get(urlString: "http://www.example.com")
                
                
                expect(spySessionDataTask.resume_wasCalled).to(beTrue())
            }
            
            it("returns a future which resolves the request with response data") {
                let responseData = "response".data(using: String.Encoding.utf8)
                spyStubNetworkSession.dataTask_completionHandler_inputs = responseData
                
                
                let responseFuture = networkHttp.get(urlString: "http://www.example.com")
                
                var actualData: Data?
                responseFuture.onSuccess { data in
                    actualData = data
                }
                
                
                expect(actualData).toEventually(equal(responseData))
            }
            
        }
    }
}
