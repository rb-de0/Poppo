
class Poppo{

    private let oauthClient: OAuthClient
    
    init(consumerKey: String, consumerKeySecret: String, accessToken: String, accessTokenSecret: String) {
        
        oauthClient = OAuthClient(
            consumerKey: consumerKey,
            consumerKeySecret: consumerKeySecret,
            accessToken: accessToken,
            accessTokenSecret: accessTokenSecret
        )
    }
        
    func tweet(status: String){
        oauthClient.tweet(status: status)
    }
}
