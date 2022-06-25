import Foundation
import BrightFutures

protocol NetworkSession {
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask
}

extension URLSession: NetworkSession {}

protocol Http {
    func get(urlString: String) -> Future<Data, Error>
}

struct NetworkHttp: Http {
    let networkSession: NetworkSession
    
    func get(urlString: String) -> Future<Data, Error> {
        let requestPromise = Promise<Data, Error>()
        
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        
        networkSession.dataTask(with: urlRequest) { (maybeData, maybeUrlResponse, maybeError) in
            if let data = maybeData {
                requestPromise.success(data)
            }
        }
        .resume()
        
        return requestPromise.future
    }
}
