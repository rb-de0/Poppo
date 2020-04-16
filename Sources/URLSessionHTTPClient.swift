import Foundation
import Dispatch
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

// URLSession Client
class URLSessionHTTPClient: HTTPClient {
    
    private let semaphore = DispatchSemaphore(value: 0)
    
    func sendRequest(request: URLRequest){
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request){(data, resp, err) in
            self.semaphore.signal()
            
        }
        task.resume()
        semaphore.wait()
    }
}
