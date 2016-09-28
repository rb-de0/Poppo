
public class Poppo{

    private let oauthClient: OAuthClient
    
    public init(consumerKey: String, consumerKeySecret: String, accessToken: String, accessTokenSecret: String) {
        
        oauthClient = OAuthClient(
            consumerKey: consumerKey,
            consumerKeySecret: consumerKeySecret,
            accessToken: accessToken,
            accessTokenSecret: accessTokenSecret
        )
    }
        
    public func tweet(status: String){
        oauthClient.tweet(status: status)
    }
}
