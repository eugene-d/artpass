import ObjectMapper
import Foundation

class Events: Mappable {
    var events: [Event]?
    
    static func orderByDate(events: [Event]) -> [Event] {
        func sortEvent(event1: Event, event2: Event) -> Bool {
            let comparison = event1.dates![0].compare(event2.dates![0])
            return comparison == NSComparisonResult.OrderedAscending
        }
        
        return events.sort(sortEvent)
    }
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        events <- map["events"]
    }
}
