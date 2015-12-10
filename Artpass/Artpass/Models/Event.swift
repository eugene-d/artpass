import ObjectMapper


class Event: Mappable {
    var title: String?
    var type: String?
    var dates: [NSDate]?
    var ticketsLeft: Int?
    var overview: String?
    var artists: [Artist]?
    var coverImg: String?
    var place: Place?
    
    static let serverDateFormat = "YYYY-MM-dd"
    static let timezone = "UTC"
    
    required init?(_ map: Map) {
        
    }
    
    static func dateToFormatedString(date: NSDate, format: String = "YYYY-MM-dd") -> String {
        let outputFormater = NSDateFormatter()
        outputFormater.dateFormat = format
        
        return outputFormater.stringFromDate(date)
    }
    
    static func dateFormater() -> NSDateFormatter {
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: self.timezone)
        dateFormatter.dateFormat = self.serverDateFormat
        
        return dateFormatter
    }
    
    static func stringToDate(dateString: String) -> NSDate {
        return self.dateFormater().dateFromString(dateString)!
    }
    
    static func dateToStrings(date: NSDate) -> String {
        return self.dateFormater().stringFromDate(date)
    }
    
    static func eventPeriod(startPeriod: NSDate, endPeriod: NSDate ) -> String {
        let calendar = NSCalendar.currentCalendar()
        let startComponents = calendar.components([.Year, .Month, .Day], fromDate: startPeriod)
        let endComponents = calendar.components([.Year, .Month, .Day], fromDate: endPeriod)
        var period = ""
        
        if (startComponents.year == endComponents.year) {
            if (startComponents.month == endComponents.month) {
                period = [
                    self.dateToFormatedString(startPeriod, format: "dd"),
                    "-",
                    self.dateToFormatedString(endPeriod, format: "dd MMM")
                ].joinWithSeparator("")
            } else {
                period = [
                    self.dateToFormatedString(startPeriod, format: "dd MMM"),
                    "-",
                    self.dateToFormatedString(endPeriod, format: "dd MMM")
                ].joinWithSeparator("")
            }
        } else {
            period = [
                self.dateToFormatedString(startPeriod, format: "MMM dd, YYYY"),
                "-",
                self.dateToFormatedString(endPeriod, format: "MMM dd, YYYY")
                ].joinWithSeparator("")
        }
        return period
    }
    
    func mapping(map: Map) {
        
        let toDate = TransformOf<[NSDate], [String]>(fromJSON: { (value: [String]?) -> [NSDate]? in
            
            if let value = value {
                let dates = value.map(Event.stringToDate)
                return dates
            }
            
            return nil
            }, toJSON: { (value: [NSDate]?) -> [String]? in
                if let value = value {
                    return value.map(Event.dateToStrings)
                }
                
                return nil
        })
        
        title <- map["title"]
        type <- map["type"]
        dates <- (map["dates"], toDate)
        ticketsLeft <- map["tickets_left"]
        overview <- map["overview"]
        artists <- map["artists"]
        coverImg <- map["cover_img"]
        place <- map["place"]
    }
}
