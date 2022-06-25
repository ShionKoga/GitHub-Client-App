import Foundation

class SpySessionDataTask: URLSessionDataTask {
    private(set) var resume_wasCalled: Bool  = false
    override func resume() {
        resume_wasCalled = true
    }
}

