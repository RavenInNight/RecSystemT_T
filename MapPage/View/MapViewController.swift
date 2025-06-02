import UIKit
import MapKit

final class MapViewController: UIViewController {
    private var presenter: MapPresenterInput
    private var mapView: MKMapView!

    override func loadView() {
        mapView = MKMapView()
        mapView?.delegate = self
        view = mapView
    }
    
    init(presenter: MapPresenterInput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        presenter.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(_:)))
        mapView.addGestureRecognizer(tapGesture)
    }

    @objc private func handleMapTap(_ gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: mapView)
        let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
        presenter.didTapOnCoordinate(coordinate)
    }

    func inject(presenter: MapPresenterInput) {
        self.presenter = presenter
    }
}

extension MapViewController: MapViewInput {
    func setupInitialRegion(_ region: MKCoordinateRegion) {
        mapView.setRegion(region, animated: true)
    }
    
    func addAnnotation(at coordinate: CLLocationCoordinate2D, title: String?) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        mapView.addAnnotation(annotation)
        print("Added annotation \(title ?? "No Title") at \(coordinate.latitude), \(coordinate.longitude)")
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        let identifier = "CustomAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
}
