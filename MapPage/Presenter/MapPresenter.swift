import MapKit
import CoreLocation

final class MapPresenter {
    weak var view: MapViewInput?
    
    private let moscowPoints: [(title: String, coordinate: CLLocationCoordinate2D)] = [
        ("Красная площадь", CLLocationCoordinate2D(latitude: 55.7539, longitude: 37.6208)),
        ("Москва-Сити", CLLocationCoordinate2D(latitude: 55.7486, longitude: 37.5394)),
        ("Парк Горького", CLLocationCoordinate2D(latitude: 55.7298, longitude: 37.6011)),
        ("ВДНХ", CLLocationCoordinate2D(latitude: 55.8254, longitude: 37.6388))
    ]
    
    private func showPredefinedPoints() {
        for point in moscowPoints {
            view?.addAnnotation(at: point.coordinate, title: point.title)
        }
    }
}

extension MapPresenter: MapPresenterInput {
    
    func viewDidLoad() {
        let center = CLLocationCoordinate2D(latitude: 55.751244, longitude: 37.618423)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0))
        view?.setupInitialRegion(region)
        
        DispatchQueue.main.async {
            self.showPredefinedPoints()
        }
    }
    
    func didTapOnCoordinate(_ coordinate: CLLocationCoordinate2D) {
        view?.addAnnotation(at: coordinate, title: "Выбранная точка")
    }
}
