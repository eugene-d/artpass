import UIKit

protocol EventTypeFilterDelegate {
    func addTypeFilter(options: [EventType])
    func addDateFilter(options: [Period])
    func addCityFilter(options: [String])
}

class HomeFilterController: BaseViewController {
    var cellIdentifier = "filterType"
    
    var eventTypeFilterDelegate: EventTypeFilterDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        self.navigationItem.title = "ARTPASS"
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Back"), style: .Plain, target: self, action: "sendFilter")
    }
    
    func sendFilter() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    class func checkedCellAccessoryView() -> UIImageView {
        return UIImageView.init(image: UIImage.init(named: "Dots fill"))
    }
    
    class func uncheckedCellAccessoryView() -> UIImageView {
        return UIImageView.init(image: UIImage.init(named: "Dots clear"))
    }
}
