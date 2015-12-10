import UIKit
import MapKit

class LocationInfoContoller: BaseViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var navbarTitle: UILabel!
    @IBOutlet weak var navbarPlace: UILabel!

    var eventInfo: Event?

    let regionRadius: CLLocationDistance = 1000

    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoOnNavigationBar()
        eventMapPin()
    }

    func eventMapPin() {
        if let place = self.eventInfo?.place {
            let location = CLLocation(latitude: place.lat!, longitude: place.lon!)
            let pinLocation = location.coordinate
            let region = MKCoordinateRegionMakeWithDistance(location.coordinate,
                    regionRadius * 2.0, regionRadius * 2.0)
            mapView.setRegion(region, animated: true)

            let annotation = MKPointAnnotation()
            annotation.coordinate = pinLocation
            annotation.title = place.title!
            
            mapView.addAnnotation(annotation)
        }
    }
    
    func infoOnNavigationBar() {
        self.navbarTitle.text = self.eventInfo!.title
        self.navbarPlace.text = self.eventInfo!.place!.title!
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationController = segue.destinationViewController as? LocationInfoTableController {
            destinationController.eventInfo = self.eventInfo
        }
    }
}
