import UIKit

protocol EventsViewControllerDelegage {
    func getEventList() -> [Event];
    func updateEventsFilters(cityFilter: [CustomFilter: Any]);
}

enum CustomFilter: Int {
    case EventType
    case Period
    case City
}

class HomeEventsFilterController: UITableViewController, EventTypeFilterDelegate {
    var eventsControllerDelegate: EventsViewControllerDelegage?
    var eventsList: [Event]?
    
    var typeFilters = [EventType]()
    var dateFilters = [Period]()
    var cityFilters = [String]()
    
    @IBAction func doneAction(sender: UIBarButtonItem) {
        let filters: [CustomFilter: Any] = [
            CustomFilter.EventType: self.typeFilters,
            CustomFilter.Period: self.dateFilters,
            CustomFilter.City: self.cityFilters
        ]
        self.eventsControllerDelegate?.updateEventsFilters(filters)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.eventsList = self.eventsControllerDelegate!.getEventList()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let segueId = segue.identifier {
            
            switch segueId {
            case "HomeFilterTypeController":
                if let vc = segue.destinationViewController as? HomeFilterTypeController {
                    vc.tableViewData = availableEventTypes()
                    vc.eventTypeFilterDelegate = self
                }
            case "HomeFilterPlaceController":
                if let vc = segue.destinationViewController as? HomeFilterPlaceController {
                    vc.tableViewData = availableCities()
                    vc.eventTypeFilterDelegate = self
                }
            case "HomeFilterPeriodController":
                if let vc = segue.destinationViewController as? HomeFilterPeriodController {
                    vc.tableViewData = availableDates()
                    vc.eventTypeFilterDelegate = self
                }
            default:
                print("found nothing")
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath)
        var textLabel = ""

        switch indexPath.section {
        case CustomFilter.EventType.rawValue:
            textLabel = self.typeFilters.map{$0.title}.joinWithSeparator(", ")
            
        case CustomFilter.Period.rawValue:
            textLabel = self.dateFilters.map{$0.title}.joinWithSeparator(", ")
            
        case CustomFilter.City.rawValue:
            textLabel = self.cityFilters.joinWithSeparator(", ")
            
        default: break
        }
        
        cell.textLabel?.text = textLabel
        cell.accessoryView = UIImageView.init(image: UIImage.init(named: "Dots"))
        
        return cell
    }
    
    func addTypeFilter(options: [EventType]) {
        self.typeFilters = options
        self.tableView.reloadData()
    }
    
    func addDateFilter(options: [Period]) {
        self.dateFilters = options
        self.tableView.reloadData()
    }
    
    func addCityFilter(options: [String]) {
        self.cityFilters = options
        self.tableView.reloadData()
    }
    
    func availableEventTypes() -> [EventType] {
        var eventTypes = [EventType]()
        
        if let events = self.eventsList {
            events.forEach({(event) in
                if (!eventTypes.contains(event.type!)) {
                    eventTypes.append(event.type!)
                }
            })
        }
        
        return eventTypes
    }
    
    func availableCities() -> [String] {
        var cities = [String]()
        
        if let events = self.eventsList {
            events.forEach({(event) in
                if (!cities.contains(event.place!.city!)) {
                    cities.append(event.place!.city!)
                }
            })
        }
        
        return cities
    }
    
    func availableDates() -> [Period] {
        return Period.all()
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView

        headerView.textLabel!.text = headerView.textLabel!.text?.capitalizedString
        headerView.textLabel?.font = UIFont.systemFontOfSize(12.0)
        headerView.textLabel?.textColor = UIColor(white: 1, alpha: 0.4)
        headerView.contentView.backgroundColor = UIColor.blackColor()
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }    
}