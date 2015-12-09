import UIKit

protocol EventsViewControllerDelegage {
    func getEventList() -> [Event];
    func updateEventsFilters();
}


class HomeEventsFilterController: UITableViewController, EventTypeFilterDelegate {
    var eventsControllerDelegate: EventsViewControllerDelegage?
    var eventsList: [Event]?
    
    @IBAction func doneAction(sender: UIBarButtonItem) {
        eventsControllerDelegate?.updateEventsFilters()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.eventsList = self.eventsControllerDelegate!.getEventList()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let segueId = segue.identifier {
            switch segueId {
            case "selectEventType":
                if let vc = segue.destinationViewController as? HomeFilterTypeView {
                    vc.tableViewData = availableEventTypes()
                    vc.eventTypeFilterDelegate = self
                }
            default:
                print("found nothing")
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath)
//        cell.textLabel?.text = cell.textLabel!.text! + " - test \(indexPath.section)"
        cell.accessoryView = UIImageView.init(image: UIImage.init(named: "Dots"))
        
        return cell
    }
    
    func addFelterOptions(options: [String]) {
        print("Got options \(options)")
        
    }
    
    func availableEventTypes() -> [String] {
        var eventTypes = [String]()
        
        if let events = self.eventsList {
            events.forEach({(event) in
                if (!eventTypes.contains(event.type!)) {
                    eventTypes.append(event.type!)
                }
            })
        }
        
        return eventTypes
    }
  
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView

        headerView.textLabel!.text = headerView.textLabel!.text?.capitalizedString
        headerView.textLabel?.font = UIFont.systemFontOfSize(8.0)
        headerView.textLabel?.textColor = UIColor(white: 1, alpha: 0.3)
        headerView.contentView.backgroundColor = UIColor.blackColor()
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }    
}