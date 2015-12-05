import Foundation
import UIKit
import Alamofire
import ObjectMapper

class HomeEventsListView: BaseViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    let cellIdentifier = "homeEventCell"
    let cellNibFile = "HomeEventCell"
    let scopeButtons = ["All", "Opera", "Ballet", "Symphony"]
    
    var searchResultController: UISearchController!

    let urlData = "https://gist.githubusercontent.com/eugene-d/c9dc0f8c23555e9b0e14/raw/99d2e5f421ec2afb1150551bb688c9e14ffb8fc3/data.json"
    
    var eventList: Array<Event> = []
    var filteredEventList: Array<Event> = []
    
    override func viewDidLoad() {
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.searchResultController = UISearchController(searchResultsController: nil)
        self.searchResultController.searchResultsUpdater = self
        self.searchResultController.dimsBackgroundDuringPresentation = false
        self.searchResultController.searchBar.scopeButtonTitles = scopeButtons
        self.searchResultController.searchBar.sizeToFit()
        self.searchResultController.searchBar.delegate = self
        self.tableView.tableHeaderView = self.searchResultController.searchBar
        self.tableView.reloadData()
        
        
        Alamofire.request(.GET, urlData)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if let eventsResponse = Mapper<Events>().map(response.result.value) {
                        self.eventList = eventsResponse.events!
                        self.tableView.reloadData()
                    }
                    
                case .Failure(let error):
                    print(error)
                }
        }
        
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
        cell?.dateLabel.text = event.dates?.joinWithSeparator("-")
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
                return event.type!.caseInsensitiveCompare(scopeType) == NSComparisonResult.OrderedSame
            }
            
            let array = (self.eventList as NSArray).filteredArrayUsingPredicate(searchBlock)
            
            self.filteredEventList = array as! [Event]
        }
        
        self.tableView.reloadData()
    }
}
