import ObjectMapper

class Artist: Mappable {
    var name: String?
    var stageName: String?
    
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        stageName <- map["stage_name"]
    }
}
