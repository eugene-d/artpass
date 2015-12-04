import UIKit
import AlamofireObjectMapper
import Alamofire
import ObjectMapper

class HomeEventsListView: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    let cellIdentifier = "homeEventCell"
    let cellNibFile = "HomeEventCell"

    let urlData = "https://gist.githubusercontent.com/Makazone/2804db3308fa67f3d900/raw/5831da4526e81640fe6d16521c7640c2fc811645/data.json"
    
    var eventList: Array<Event> = []
    
    override func viewDidLoad() {
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        
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
        return self.eventList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: HomeEventCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? HomeEventCell
        
        if (cell == nil) {
            tableView.registerNib(UINib(nibName: cellNibFile, bundle: NSBundle.mainBundle()), forCellReuseIdentifier: cellIdentifier);
            
            cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? HomeEventCell
        }
        
        let event = self.eventList[indexPath.row]
        
        cell?.titleLabel.text = event.title
        cell?.cityLabel.text = event.place?.city
        cell?.dateLabel.text = event.dates?.joinWithSeparator("-")
        
        return cell!
    }
}
