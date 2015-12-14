import UIKit

class HomeFilterPlaceController: HomeFilterController, UITableViewDelegate, UITableViewDataSource {
    
    var tableViewData: [String]?
    var filterOptions = [String]()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.tableViewData?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier, forIndexPath: indexPath)
        
        cell.textLabel?.text = tableViewData?[indexPath.row]
        cell.accessoryView = HomeFilterController.uncheckedCellAccessoryView()
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.tableView.cellForRowAtIndexPath(indexPath)
        cell!.accessoryView = HomeFilterController.checkedCellAccessoryView()
        
        filterOptions.append(tableViewData![indexPath.row])
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.tableView.cellForRowAtIndexPath(indexPath)
        cell!.accessoryView = HomeFilterController.uncheckedCellAccessoryView()
        
        let option = tableViewData![indexPath.row]
        let optionIndex = filterOptions.indexOf(option)
        filterOptions.removeAtIndex(optionIndex!)
    }
    
    override func willMoveToParentViewController(parent: UIViewController?) {
        if parent == nil {
            eventTypeFilterDelegate!.addCityFilter(filterOptions)
        }
    }
}
