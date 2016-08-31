import Foundation

class Poppo: NSObject, URLSessionDelegate{
    func connect(){
        let request = URLRequest(url: URL(string: "https://www.google.com")!)

        let configuration = URLSessionConfiguration()
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        let task = session.dataTask(with: request)

        task.resume()
    }

    func urlSession(_ session: URLSession, didReceiveChallenge challenge: URLAuthenticationChallenge, completionHandler: (URLSession.AuthChallengeDisposition, URLCredential?) -> Void){

    }

    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: NSError?){

    }
}