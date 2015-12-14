import Foundation

protocol EventFilter {
    func applyFilter(events: [Event]) -> [Event]
    func title() -> String
}

class FilterEvents {
    var defaultFilters = ["All"]
    var filters = [EventFilter]()
    
    func applyFilter(index: Int, forEvents events: [Event]) -> [Event] {
        let defaultFiltersCount = defaultFilters.count
        if (index > defaultFiltersCount - 1) {
            let filter = self.filters[index - defaultFiltersCount]
            return filter.applyFilter(events)
        } else {
            return events
        }
    }
    
    func updateFilters(filters: [CustomFilter: Any]) {
        self.filters = []
        
        for (filterType, options) in filters {
            switch filterType {
                
            case .City:
                let cities = options as! [String];
                self.filters += FilterCity.createBatch(cities)
                
            case .Period:
                let dates = options as! [Period]
                self.filters += FilterPeriod.createBatch(dates)
                
            case.EventType:
                let types = options as! [EventType]
                self.filters += FilterEventType.createBatch(types)
            }
        }
    }
    
    func titles() -> [String] {
        return self.defaultFilters + self.filters.map {$0.title()}
    }
}