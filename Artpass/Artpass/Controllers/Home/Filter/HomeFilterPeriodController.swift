import UIKit

class HomeFilterPeriodController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var eventTypeFilterDelegate: EventTypeFilterDelegate?
    
    var tableViewData: [Period]?
    var filterOptions = [Period]()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.navigationItem.title = "ARTPASS"
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.tableViewData?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("filterType", forIndexPath: indexPath)
        
        cell.textLabel?.text = tableViewData?[indexPath.row].title
        cell.accessoryView = UIImageView.init(image: UIImage.init(named: "Dots clear"))
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.tableView.cellForRowAtIndexPath(indexPath)
        cell!.accessoryView = UIImageView.init(image: UIImage.init(named: "Dots fill"))
        
        filterOptions.append(tableViewData![indexPath.row])
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.tableView.cellForRowAtIndexPath(indexPath)
        cell!.accessoryView = UIImageView.init(image: UIImage.init(named: "Dots clear"))
        
        let option = tableViewData![indexPath.row]
        let optionIndex = filterOptions.indexOf(option)
        filterOptions.removeAtIndex(optionIndex!)
    }
    
    override func willMoveToParentViewController(parent: UIViewController?) {
        if parent == nil {
            eventTypeFilterDelegate!.addDateFilter(filterOptions)
        }
    }
}
