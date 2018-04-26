
class URLEncoder{
    let unreservedStrings = "-._~"
    let reservedStrings = "!#$&'()*+,/:;=?@[]"
    
    func encoded(_ target: String) -> String{
        var encodedString = ""
        
        for code in target {
            
            if isUnreserved(String(code)){
                encodedString += String(code)
                continue
            }
            
            for c in String(code).utf8{
                let str16 = String(c, radix: 16)
                encodedString += "%" + str16.uppercased()
            }
        }
        
        return encodedString
    }
    
    func isUnreserved(_ target: String) -> Bool{
        return (target >= "a" && target <= "z")
            || (target >= "A" && target <= "Z")
            || (target >= "0" && target <= "9")
            || unreservedStrings.contains(target)
    }
}
