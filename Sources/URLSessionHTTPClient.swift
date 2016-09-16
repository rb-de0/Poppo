import Foundation
import Dispatch

// URLSession Client
class URLSessionHTTPClient: HTTPClient{
    
    private let semaphore = DispatchSemaphore(value: 0)
    
    func sendRequest(request: URLRequest){
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request){(data, resp, err) in
            print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue), resp, err)
            self.semaphore.signal()
            
        }
        task.resume()
        semaphore.wait()
    }
}
