import UIKit

class HomeEventCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        if #available(iOS 9, *) {
            self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        } else {
//            self.titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        let view = UIView()
        view.backgroundColor = UIColor.grayColor()
        selectedBackgroundView = view
    }
}
