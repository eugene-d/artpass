import ObjectMapper

class Place: Mappable {
    
    var city: String?
    var title: String?
    var phone: String?
    var address: String?
    var lat: Double?
    var lon: Double?
    var category: String?
    var openingHours: String?
    var price: Int?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        city <- map["city"]
        title <- map["title"]
        phone <- map["phone"]
        address <- map["address"]
        lat <- map["lat"]
        lon <- map["lon"]
        category <- map["category"]
        openingHours <- map["opening_hours"]
        price <- map["price"]
    }
}
