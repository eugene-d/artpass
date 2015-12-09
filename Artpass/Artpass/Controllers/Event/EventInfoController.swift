import UIKit

class EventInfoController: UIViewController {
    var eventInfo: Event?
    
    @IBOutlet weak var eventImageCover: UIImageView!
    @IBOutlet weak var eventTitle: UITextView!
    @IBOutlet weak var eventPlace: UITextView!
    @IBOutlet weak var eventCity: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.clearColor();
        
        showEventInfo();
    }
    
    @IBAction func openLocation(sender: AnyObject) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewControllerWithIdentifier("LocationInfoContoller") as! LocationInfoContoller
        
        vc.eventInfo = self.eventInfo
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showEventInfo() {
        self.eventTitle.text = self.eventInfo!.title!
        self.eventPlace.text = self.eventInfo!.place!.title
        self.eventCity.text = self.eventInfo!.place!.city
        loadCoverImage()
    }
    
    func loadCoverImage() {
        dispatch_async(dispatch_get_global_queue(0,0), {
            let urlData = NSData(contentsOfURL: NSURL(string: self.eventInfo!.coverImg!)!)
            if ( urlData == nil ) {
                return;
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.eventImageCover.image = UIImage(data: urlData!)
            });
        });
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationController = segue.destinationViewController as? EventInfoTableView {
            destinationController.eventInfo = self.eventInfo
        }
    }
}
