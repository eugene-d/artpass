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
        self.navigationItem.title = "ARTPASS"
    }
    
    class func checkedCellAccessoryView() -> UIImageView {
        return UIImageView.init(image: UIImage.init(named: "Dots fill"))
    }
    
    class func uncheckedCellAccessoryView() -> UIImageView {
        return UIImageView.init(image: UIImage.init(named: "Dots clear"))
    }
}
