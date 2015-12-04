import ObjectMapper

class Event: Mappable {
    var title: String?
    var type: String?
    var dates: [String]?
    var ticketsLeft: Int?
    var overview: String?
    var artists: [Artist]?
    var coverImg: String?
    var place: Place?
    
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        type <- map["type"]
        dates <- map["dates"]
        ticketsLeft <- map["tickets_left"]
        overview <- map["overview"]
        artists <- map["artists"]
        coverImg <- map["cover_img"]
        place <- map["place"]
    }
}
