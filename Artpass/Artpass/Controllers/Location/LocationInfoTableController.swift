import UIKit

class LocationInfoTableController: UITableViewController {
    
    @IBOutlet weak var fullAddress: UITextView!
    @IBOutlet weak var prices: UILabel!
    @IBOutlet weak var hours: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var category: UILabel!
    
    var priceNatural = ["$", "$$", "$$$"]
    var eventInfo: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showEventInfo()
    }
    
    func showEventInfo() {
        if let place = self.eventInfo?.place {
            self.fullAddress.text = place.fullAddress!
            self.category.text = place.category!
            self.hours.text = place.openingHours!
            self.phone.text = place.phone!
            
            switch place.price! {
            case 0..<10:
                self.prices.text = priceNatural[0]
            case 10..<100:
                self.prices.text = priceNatural[1]
            default:
                self.prices.text = priceNatural[2]
            }
        }
    }
}
