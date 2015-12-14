import Foundation

class FilterPeriod: EventFilter {
    var filter: Period
    
    required init(filter: Period) {
        self.filter = filter
    }
    
    func applyFilter(events: [Event]) -> [Event] {
        let searchBlock = NSPredicate {(evaluatedObject, _) in
            let event = evaluatedObject as! Event
            
            return self.filter.interval[0] <= event.dates![0] &&
                event.dates![1] <= self.filter.interval[1]
        }
        
        let result = (events as NSArray).filteredArrayUsingPredicate(searchBlock) as! [Event]
        
        return result
    }
    
    func title() -> String {
        return self.filter.title
    }
    
    static func createBatch(events: [Period]) -> [EventFilter] {
        return events.map {FilterPeriod(filter: $0) } as [EventFilter]
    }
}