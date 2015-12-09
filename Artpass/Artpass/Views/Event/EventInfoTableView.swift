import UIKit

class EventInfoTableView: UITableViewController {
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var ticketsLeft: UILabel!
    @IBOutlet weak var eventOverview: UITextView!
    
    let cellNibFile = "EventArtistCell"
    let cellIdentifier = "EventArtistCell"
    let artistsSectionIndex = 1;
    
    var eventInfo: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: cellNibFile, bundle: NSBundle.mainBundle()), forCellReuseIdentifier: cellIdentifier)
        
        assignEventInfo()
    }
    
    func assignEventInfo() {
        self.ticketsLeft.text = String(self.eventInfo!.ticketsLeft!)
        self.eventOverview.text = self.eventInfo!.overview!
        
        assignEventDate()
    }
    
    func assignEventDate() {
        let inputFormater = NSDateFormatter()
        inputFormater.timeZone = NSTimeZone(name: "UTC")
        inputFormater.dateFormat = "YYYY-MM-dd"
        
        if let date = inputFormater.dateFromString((self.eventInfo?.dates?.first)!) {
            let outputFormater = NSDateFormatter()
            outputFormater.dateFormat = "EEE, d MMM";
            self.eventDate.text = outputFormater.stringFromDate(date)
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == artistsSectionIndex) {
            return (self.eventInfo?.artists?.count)!
        } else {
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.section == artistsSectionIndex && indexPath.row > 0) {
            var cell: EventArtistCell?
            cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? EventArtistCell
            
                cell?.name.text = self.eventInfo?.artists![indexPath.row].name
                cell?.stageName.text  = self.eventInfo?.artists![indexPath.row].stageName
                customDisclosureView(cell!)
            return cell!
        } else {
            let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath)
            customDisclosureView(cell)
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            if (indexPath.section == artistsSectionIndex) {
                let cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
                return cell!.frame.height
            } else {
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
    }
    
    override func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        return 0
    }
    
    func customDisclosureView(cell: UITableViewCell) {
        cell.accessoryView = UIImageView.init(image: UIImage.init(named: "Brown dots"))
    }
}
