import Foundation
import UIKit
import Alamofire
import ObjectMapper

class HomeEventsListView: BaseViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate, EventsViewControllerDelegage {
    
    @IBOutlet var tableView: UITableView!
    
    let cellIdentifier = "homeEventCell"
    let cellNibFile = "HomeEventCell"
    let scopeButtons = ["All", EventType.Opera.title, EventType.Ballet.title, EventType.Symphony.title]
    
    var searchResultController: UISearchController!

    let urlData = "https://gist.githubusercontent.com/eugene-d/c9dc0f8c23555e9b0e14/raw/b55cc9647d6c04ed21040b06f97fe7ec1bc0ff10/data.json"
    
    var eventList: Array<Event> = []
    var filteredEventList: Array<Event> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "ARTPASS"
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.searchResultController = UISearchController(searchResultsController: nil)
        self.searchResultController.searchResultsUpdater = self
        self.searchResultController.dimsBackgroundDuringPresentation = false
        self.searchResultController.searchBar.scopeButtonTitles = scopeButtons
        self.searchResultController.searchBar.sizeToFit()
        self.searchResultController.searchBar.delegate = self
        self.searchResultController.searchBar.barTintColor = UIColor.blackColor()
        self.tableView.tableHeaderView = self.searchResultController.searchBar
        self.tableView.reloadData()
        
        
        Alamofire.request(.GET, urlData)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if let eventsResponse = Mapper<Events>().map(response.result.value) {
                        self.eventList = Events.orderByDate(eventsResponse.events!)
                        self.tableView.reloadData()
                    }
                    
                case .Failure(let error):
                    print(error)
                }
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? UINavigationController {
            if let destinationController = vc.visibleViewController as? HomeEventsFilterController {
                destinationController.eventsControllerDelegate = self
            }
        }
    }
    
    func updateEventsFilters() {
        // TODO update filters options
    }
    
    func getEventList() -> [Event] {
        return self.eventList
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchResultController.active {
            return self.filteredEventList.count
        } else {
            return self.eventList.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var event: Event!
        var cell: HomeEventCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? HomeEventCell
        
        if (cell == nil) {
            tableView.registerNib(UINib(nibName: cellNibFile, bundle: NSBundle.mainBundle()), forCellReuseIdentifier: cellIdentifier);
            
            cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? HomeEventCell
        }
        
        
        if (self.searchResultController.active) {
            event = self.filteredEventList[indexPath.row]
        } else {
            event = self.eventList[indexPath.row]
        }
        
        cell?.titleLabel.text = event.title
        cell?.cityLabel.text = event.place?.city
        cell?.dateLabel.text = Event.eventPeriod(event.dates![0], endPeriod: event.dates![1])
        return cell!
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        self.filteredEventList.removeAll(keepCapacity: false)
        
        let searchBlock = NSPredicate {(evaluatedObject, _) in
            let event = evaluatedObject as! Event
            return event.title!.localizedCaseInsensitiveContainsString(self.searchResultController.searchBar.text!)
        }
        
        let array = (self.eventList as NSArray).filteredArrayUsingPredicate(searchBlock)
        
        self.filteredEventList = array as! [Event]
        self.tableView.reloadData()
    }
    
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        if (selectedScope > 0) {
            let scopeType = self.scopeButtons[selectedScope];
            let searchBlock = NSPredicate {(evaluatedObject, _) in
                let event = evaluatedObject as! Event
                return event.type!.title.caseInsensitiveCompare(scopeType) == NSComparisonResult.OrderedSame
            }
            
            let array = (self.eventList as NSArray).filteredArrayUsingPredicate(searchBlock)
            
            self.filteredEventList = array as! [Event]
        }
        
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewControllerWithIdentifier("EventInfoController") as! EventInfoController
        
        if (self.searchResultController.active == true) {
            vc.eventInfo = self.filteredEventList[indexPath.row]
        } else {
            vc.eventInfo = self.eventList[indexPath.row]
        }
        
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
