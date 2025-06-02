import CoreLocation
import MapKit

protocol MapViewInput: AnyObject {
    func setupInitialRegion(_ region: MKCoordinateRegion)
    func addAnnotation(at coordinate: CLLocationCoordinate2D, title: String?)
}
