import Foundation

class Poppo: NSObject, URLSessionDelegate{

    let semaphore = DispatchSemaphore(value: 0)

    func connect(){
        let request = URLRequest(url: URL(string: "http://www.example.com/")!)

        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
        session.dataTask(with: request){(data, response, error) in
            print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue))
            self.semaphore.signal()
        }.resume()
        
        semaphore.wait()
    }
}