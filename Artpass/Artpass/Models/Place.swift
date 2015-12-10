import ObjectMapper

class Place: Mappable {
    
    var city: String?
    var title: String?
    var phone: String?
    var fullAddress: String?
    var lat: Double?
    var lon: Double?
    var category: String?
    var openingHours: String?
    var price: Int?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        let transformToDouble = TransformOf<Double, String>(fromJSON: {Double($0!)}, toJSON: {$0.map {String($0)}})
        
        city <- map["city"]
        title <- map["title"]
        phone <- map["phone"]
        fullAddress <- map["full_address"]
        lat <- (map["lat"], transformToDouble)
        lon <- (map["lon"], transformToDouble)
        category <- map["category"]
        openingHours <- map["openning_hours"]
        price <- map["price"]
    }
}
