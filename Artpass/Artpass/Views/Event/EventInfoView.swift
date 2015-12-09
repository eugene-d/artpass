import UIKit

class EventInfoView: UITableViewController {
    override func viewDidLoad() {
        //        super.viewDidLoad()
        self.tableView.opaque = false
        self.tableView.backgroundColor = UIColor.clearColor()
        let imgView = UIImageView(image: UIImage())
        imgView.tag = 1
        self.view.addSubview(imgView)
        self.tableView.sendSubviewToBack(imgView)
        //        print(self.tableView.bounds)
        //        self.tableView.bounds.origin = CGPointMake(0, 100)
        //        print(self.tableView.bounds)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.clearColor();
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //        self.tableView.frame = CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height)
        let imageView = self.tableView.viewWithTag(1)!
        
        imageView.frame = CGRectMake(0, -60, imageView.bounds.size.width, imageView.bounds.size.height)
        //        for view in self.tableView.subviews {
        //            print(view.tag)
        //        }
        
    }
}
