import UIKit

protocol CustomFilterEventsDelegate {
    func applyCustomFilter(selectedFilter: Int)
}

class FilterScrollView: UIScrollView {
    
    var buttons = [FilterButton]()
    var keysConstraints = [String]()
    var buttonsConstraints = [String: FilterButton]()
    var customFilterEventsDelegate: CustomFilterEventsDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        createConstraints()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createConstraints() {
        self.removeConstraints(self.constraints)
        if self.buttonsConstraints.count == 0 {
            return
        }
        
        let hRules = self.keysConstraints.map {"[\($0)]"}.joinWithSeparator("-")
        let vRule = "[\(self.keysConstraints.first!)]"
        let horizontal = "H:|-\(hRules)-|"
        
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(horizontal, options: .AlignAllTop, metrics: nil, views: self.buttonsConstraints)
        self.addConstraints(horizontalConstraints)
        
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|\(vRule)", options: .AlignAllLeft, metrics: nil, views: self.buttonsConstraints)
        self.addConstraints(verticalConstraints)
    }
    
    func updateLayouts() {
        for (_, button) in self.buttonsConstraints {
            button.addBorder()
            if button.selected {
                button.showBorder()
            }
        }
    }
    
    func updateButtons(titles: [String]) {
        for button in self.buttons {
            button.removeFromSuperview()
        }
        
        self.buttons = []
        self.buttonsConstraints = [:]
        self.keysConstraints = []
        
        for (index, title) in titles.enumerate() {
            let button = FilterButton(type: .System)
            let key = "button_\(index)"

            button.setTitle(title, forState: .Normal)
            button.tag = index
            button.tintColor = UIColor.whiteColor()
            button.addTarget(self, action: "tapDetected:", forControlEvents: .TouchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            if index == 0 {
                button.selected = true
            }
            
            self.addSubview(button)
            self.buttons.append(button)
            self.keysConstraints.append(key)
            self.buttonsConstraints[key] = button
        }
        createConstraints()
    }
    
    
    func tapDetected(sender: FilterButton!) {
        if sender.isMemberOfClass(FilterButton) {
            customFilterEventsDelegate?.applyCustomFilter(sender.tag)
            sender.showBorder()
            
            for button in self.buttons {
                if button != sender {
                    button.hideBorder()
                }
            }
        }
    }
}
