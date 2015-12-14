import SwiftDate

enum Period: String {
    case Today = "today"
    case Tomorrow = "tomorrow"
    case CurrentWeek = "currentWeek"
    case NextWeek = "nextWeek"
    case CurrentMonth = "currentMonth"
    case NextMonth = "nextMonth"
    
    var interval: [NSDate] {
        switch self {
            
        case .Today:
            return todayPeriod()
            
        case .Tomorrow:
            return tomorrowPeriod()
            
        case .CurrentWeek:
            return currentWeekPeriod()
            
        case .NextWeek:
            return nextWeekPeriod()
            
        case .CurrentMonth:
            return currentMonthPeriod()
            
        case .NextMonth:
            return nextMonthPeriod()
        }
    }
    
    var title: String {
        switch self {
            
        case .Today:
            return "Today"
            
        case .Tomorrow:
            return "Tomorrow"
            
        case .CurrentWeek:
            return "Current Week"
            
        case .NextWeek:
            return "Next Week"

        case .CurrentMonth:
            return "Current Month"
            
        case .NextMonth:
            return "Next Month"
        }
    }
    
    static func all() -> [Period] {
        let periods = [
            Period.Today,
            Period.Tomorrow,
            Period.CurrentWeek,
            Period.NextWeek,
            Period.CurrentMonth,
            Period.NextMonth
        ]
        
        return periods
    }
    
    private func todayPeriod() -> [NSDate] {
        let region = Region.defaultRegion()
        let now = NSDate()
        let start = now.startOf(.Day, inRegion: region)
        let end = now.endOf(.Day, inRegion: region)
        return [start, end]
    }

    private func tomorrowPeriod() -> [NSDate] {
        let region = Region.defaultRegion()
        let now = NSDate()
        let start = now.startOf(.Day, inRegion: region)
        let end = now.endOf(.Day, inRegion: region) + 1.days
        return [start, end]
    }
    
    private func currentWeekPeriod() -> [NSDate] {
        let region = Region.defaultRegion()
        let now = NSDate()
        let startMonth = now.startOf(.Month, inRegion: region)
        let start = now.startOf(.Day, inRegion: region)
        let end = (startMonth + now.lastDayOfWeek()!.days).endOf(.Day, inRegion: region)
        return [start, end]
    }
    
    private func nextWeekPeriod() -> [NSDate] {
        let region = Region.defaultRegion()
        let nextWeek = NSDate() + 1.weeks
        let startMonth = nextWeek.startOf(.Month, inRegion: region)
        let start = (startMonth + nextWeek.firstDayOfWeek()!.days).startOf(.Day, inRegion: region)
        let end = (startMonth + nextWeek.lastDayOfWeek()!.days).endOf(.Day, inRegion: region)
        return [start, end]
    }
    
    private func currentMonthPeriod() -> [NSDate] {
        let region = Region.defaultRegion()
        let today = NSDate()
        let start = today.startOf(.Month, inRegion: region)
        let end = today.endOf(.Month, inRegion: region)
        return [start, end]
    }
    
    private func nextMonthPeriod() -> [NSDate] {
        let region = Region.defaultRegion()
        let nextMonth = NSDate() + 1.months
        let start = nextMonth.startOf(.Month, inRegion: region)
        let end = nextMonth.endOf(.Month, inRegion: region)
        return [start, end]
    }
}
