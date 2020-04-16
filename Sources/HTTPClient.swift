import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

protocol HTTPClient {
    func sendRequest(request: URLRequest)
}
