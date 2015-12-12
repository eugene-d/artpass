import Foundation

enum EventType: String {
    case Opera = "opera"
    case Symphony = "symphony"
    case Ballet = "ballet"
    case Theatre = "theatre"
    case Other = "other"
    
    var title: String {
        switch self {
            
        case .Opera:
            return "Opera"
            
        case .Symphony:
            return "Symphony"
            
        case .Ballet:
            return "Ballet"
            
        case .Theatre:
            return "Theatre"
            
        default:
            return "Other"
        }
    }
}