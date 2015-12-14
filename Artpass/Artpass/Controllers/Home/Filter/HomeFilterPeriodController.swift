import UIKit

class HomeFilterPeriodController: HomeFilterController, UITableViewDelegate, UITableViewDataSource {
    
    var tableViewData: [Period]?
    var filterOptions = [Period]()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.tableViewData?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier, forIndexPath: indexPath)
        
        cell.textLabel?.text = tableViewData?[indexPath.row].title
        cell.accessoryView = HomeFilterController.uncheckedCellAccessoryView()
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.tableView.cellForRowAtIndexPath(indexPath)
        cell!.accessoryView = HomeFilterController.checkedCellAccessoryView()
        
        filterOptions.append(tableViewData![indexPath.row])
    }
    
    override func willMoveToParentViewController(parent: UIViewController?) {
        if parent == nil {
            eventTypeFilterDelegate!.addDateFilter(filterOptions)
        }
    }
}
