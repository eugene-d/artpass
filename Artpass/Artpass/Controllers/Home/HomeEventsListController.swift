import Foundation
import UIKit
import Alamofire
import ObjectMapper

class HomeEventsListController: BaseViewController, UITableViewDelegate, UITableViewDataSource, EventsViewControllerDelegage, CustomFilterEventsDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    let cellIdentifier = "homeEventCell"
    let cellNibFile = "HomeEventCell"
    
    let urlData = "https://gist.githubusercontent.com/eugene-d/c9dc0f8c23555e9b0e14/raw/b55cc9647d6c04ed21040b06f97fe7ec1bc0ff10/data.json"
    
    var eventList: Array<Event> = []
    var filteredEventList: Array<Event> = []

    var scrollView: FilterScrollView!
    var filterEvents = FilterEvents()
    var activeEventsFilter = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "ARTPASS"
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.addScrollView()
        
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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.scrollView.updateLayouts()
    }
    
    
    func addScrollView() {
        scrollView = FilterScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
        scrollView.customFilterEventsDelegate = self
        self.view.addSubview(scrollView)
        self.scrollView.updateButtons(self.filterEvents.titles())
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? UINavigationController {
            if let destinationController = vc.visibleViewController as? HomeEventsFilterController {
                destinationController.eventsControllerDelegate = self
            }
        }
    }
    
    func updateEventsFilters(filters: [CustomFilter: Any]) {
        self.updateScopeButtons(filters)
        self.tableView.reloadData()
    }
    
    func getEventList() -> [Event] {
        return self.eventList
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.activeEventsFilter {
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
        
        
        if self.activeEventsFilter {
            event = self.filteredEventList[indexPath.row]
        } else {
            event = self.eventList[indexPath.row]
        }
        
        cell?.titleLabel.text = event.title
        cell?.cityLabel.text = event.place?.city
        cell?.dateLabel.text = Event.eventPeriod(event.dates![0], endPeriod: event.dates![1])
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewControllerWithIdentifier("EventInfoController") as! EventInfoController
        
        if (self.activeEventsFilter) {
            vc.eventInfo = self.filteredEventList[indexPath.row]
        } else {
            vc.eventInfo = self.eventList[indexPath.row]
        }
        
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateScopeButtons(filters: [CustomFilter: Any]) {
        self.filterEvents.updateFilters(filters)
        self.scrollView.updateButtons(self.filterEvents.titles())
    }
    
    func applyCustomFilter(selectedFilter: Int) {
        if selectedFilter > 0 {
            self.activeEventsFilter = true
            self.filteredEventList = self.filterEvents.applyFilter(selectedFilter, forEvents: self.eventList)
        } else {
            self.activeEventsFilter = false
            self.filteredEventList = []
        }
        self.tableView.reloadData()
    }
}
