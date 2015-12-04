import ObjectMapper

class Events: Mappable {
    var events: [Event]?
    
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        events <- map["events"]
    }
}
