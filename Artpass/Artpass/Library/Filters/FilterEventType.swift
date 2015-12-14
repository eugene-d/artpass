import Foundation

class FilterEventType: EventFilter {
    var filter: EventType
    
    required init(filter: EventType) {
        self.filter = filter
    }
    
    func applyFilter(events: [Event]) -> [Event] {
        let searchBlock = NSPredicate {(evaluatedObject, _) in
            let event = evaluatedObject as! Event
            return event.type! == self.filter
        }

        let result = (events as NSArray).filteredArrayUsingPredicate(searchBlock) as! [Event]

        return result
    }
    
    func title() -> String {
        return self.filter.title
    }
    
    static func createBatch(events: [EventType]) -> [EventFilter] {
        return events.map {FilterEventType(filter: $0) } as [EventFilter]
    }
}