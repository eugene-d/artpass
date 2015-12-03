import UIKit

class HomeTabsController: UITabBarController {
    
    let defaultActiveTabIndex = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeDefaultTabActive()
    }
    
    func makeDefaultTabActive() {
        if let viewControllersCount = viewControllers?.count
            where viewControllersCount - 1 >= defaultActiveTabIndex {
                self.selectedViewController = viewControllers?[defaultActiveTabIndex]
        }
    }
}
