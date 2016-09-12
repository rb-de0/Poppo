
struct API{
    let url: String
    let method: String
    
    static let updateStatus = API(url: "https://api.twitter.com/1.1/statuses/update.json", method: "POST")
}
