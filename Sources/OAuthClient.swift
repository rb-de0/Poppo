import Foundation
import Cryptor

class OAuthClient{
    fileprivate let consumerKey: String
    fileprivate let consumerKeySecret: String
    fileprivate let accessToken: String
    fileprivate let accessTokenSecret: String
    
    var httpClient: HTTPClient!
    
    init(consumerKey: String, consumerKeySecret: String, accessToken: String, accessTokenSecret: String) {
        self.consumerKey = consumerKey
        self.consumerKeySecret = consumerKeySecret
        self.accessToken = accessToken
        self.accessTokenSecret = accessTokenSecret
        
        self.httpClient = URLSessionHTTPClient()
    }
    
    func tweet(status: String){
        let api = API.updateStatus
        
        var request = URLRequest(url: URL(string: api.url)!)
        request.httpMethod = api.method
        request.setValue(authorizationHeader(api: api, additionalParam: ["status": urlEncode(status)]), forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        if let body = ("status=" + urlEncode(status)).data(using: String.Encoding.utf8){
            request.setValue(String(body.count), forHTTPHeaderField: "Content-Length")
            request.httpBody = body
        }
        
        httpClient.sendRequest(request: request)
    }
    
    fileprivate func urlEncode(_ target: String) -> String{
        return URLEncoder().encoded(target)
    }
}

// MARK: - Authorization Header
extension OAuthClient{
    
    fileprivate func authorizationHeader(api: API, additionalParam: [String: String]) -> String{
        var parameter = commonParameter()
        
        for (key, value) in additionalParam{
            parameter[key] = value
        }
        
        var sortedParameter = parameter.sorted{$0.0 < $1.0}
        
        var paramStr = sortedParameter.reduce(""){$0 + "&" + $1.0 + "=" + $1.1}
        paramStr = String(paramStr[paramStr.index(paramStr.startIndex, offsetBy: 1)..<paramStr.endIndex])
        
        let text = api.method + "&" + urlEncode(api.url) + "&" + urlEncode(paramStr)
        let key = urlEncode(consumerKeySecret) + "&" + urlEncode(accessTokenSecret)
        
        let textData = CryptoUtils.byteArray(from: text)
        let keyData = CryptoUtils.byteArray(from: key)
        
        let hmac = HMAC(using: HMAC.Algorithm.sha1, key: keyData).update(byteArray: textData)?.final()
        
        let data: NSData = CryptoUtils.data(from: hmac!)
        let base64Str = data.base64EncodedString()
        
        parameter["oauth_signature"] = base64Str
        
        for (key, _) in additionalParam{
            parameter[key] = nil
        }
        
        sortedParameter = parameter.sorted{$0.0 < $1.0}
        
        var headerStr = sortedParameter.reduce(""){$0 + ", " + $1.0 + "=" + "\"" + urlEncode($1.1) + "\""}
        headerStr = String(headerStr[headerStr.index(headerStr.startIndex, offsetBy: 2)..<headerStr.endIndex])
        headerStr = "OAuth " + headerStr
        
        return headerStr
    }
    
    private func commonParameter() -> [String: String]{
        var parameter: [String: String] = [:]
        
        parameter["oauth_consumer_key"] = consumerKey
        parameter["oauth_signature_method"] = "HMAC-SHA1"
        parameter["oauth_timestamp"] = timestamp()
        parameter["oauth_version"] = "1.0"
        parameter["oauth_token"] = accessToken
        parameter["oauth_nonce"] = randomStringWithLength(length: 32)
        
        return parameter
    }
    
    private func timestamp() -> String{
        return String(Int(NSDate().timeIntervalSince1970))
    }
    
    private func randomStringWithLength(length: Int) -> String {
        let alphabet = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let upperBound = alphabet.count
        
        return String((0..<length).map { _ -> Character in
            
            #if os(Linux)
                let randomValue = random()
            #else
                let randomValue = Int(arc4random())
            #endif
            
            return alphabet[alphabet.index(alphabet.startIndex, offsetBy: Int(randomValue % upperBound))]
        }).lowercased()
    }
}
