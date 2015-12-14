import Foundation

class FilterCity: EventFilter {
    var filter: String
    
    required init(filter: String) {
        self.filter = filter
    }
    
    func applyFilter(events: [Event]) -> [Event] {
        let searchBlock = NSPredicate {(evaluatedObject, _) in
            let event = evaluatedObject as! Event
            return event.place!.city!.caseInsensitiveCompare(self.filter) == NSComparisonResult.OrderedSame
        }
        
        let result = (events as NSArray).filteredArrayUsingPredicate(searchBlock) as! [Event]
        
        return result
    }
    
    func title() -> String {
        return self.filter
    }
    
    static func createBatch(cities: [String]) -> [EventFilter] {
        return cities.map {FilterCity(filter: $0) } as [EventFilter]
    }
}