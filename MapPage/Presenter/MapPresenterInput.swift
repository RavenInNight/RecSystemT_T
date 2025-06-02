import CoreLocation

protocol MapPresenterInput {
    func viewDidLoad()
    func didTapOnCoordinate(_ coordinate: CLLocationCoordinate2D)
}
