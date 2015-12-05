import UIKit

class HomeEventCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        let view = UIView()
        view.backgroundColor = UIColor.grayColor()
        selectedBackgroundView = view
    }
}
