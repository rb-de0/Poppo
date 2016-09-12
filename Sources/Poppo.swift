
class Poppo{

    private let oauthClient: OAuthClient
    
    init(){
        oauthClient = OAuthClient(
            consumerKey: "xxxxxx",
            consumerKeySecret: "xxxxxx",
            accessToken: "xxxxx",
            accessTokenSecret: "xxxx"
        )
    }
        
    func tweet(status: String){
        oauthClient.tweet(status: status)
    }
}
