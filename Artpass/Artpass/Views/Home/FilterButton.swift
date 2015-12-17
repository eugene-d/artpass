import UIKit

class FilterButton: UIButton {
    
    var borderLayer: CALayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setTitleColor(UIColor.whiteColor(), forState: .Selected)
        self.setTitleColor(UIColor.grayColor(), forState: .Normal)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addBorder() {
        self.layoutIfNeeded()
        self.addBottomBorderWithColor(UIColor.whiteColor(), borderWidth: 2.0)
    }
    
    func showBorder() {
        self.selected = true
        self.tintColor = UIColor.clearColor()
        self.borderLayer!.opacity = 1
    }
    
    func hideBorder() {
        self.selected = false
        self.tintColor = UIColor.clearColor()
        self.borderLayer!.opacity = 0
    }
    
    func addBottomBorderWithColor(color: UIColor, borderWidth: CGFloat) {
        let border = CALayer()
        border.opacity = 0
        border.backgroundColor = color.CGColor;
        border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, borderWidth);
        self.layer.addSublayer(border)
        self.borderLayer = border
//        self.titleLabel?.backgroundColor = UIColor.redColor()
    }
}
