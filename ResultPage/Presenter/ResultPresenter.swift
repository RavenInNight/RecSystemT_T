import Foundation

final class ResultPresenter {
    weak var view: ResultViewInput?
    private let router: ResultRouterInput
    private let selectedCuisines: [String]
    private let csvParser = CSVParser()
    
    init(router: ResultRouterInput, selectedCuisines: [String]) {
        self.router = router
        self.selectedCuisines = selectedCuisines
    }
}

extension ResultPresenter: ResultPresenterInput {
    
    func viewDidLoad() {
        let recommender = RestaurantRecommender()
        
        let featureWeights = [
            "cuisine": 0.7,
            "metro": 0.3
        ]
        
        if recommender.loadData(restaurants: "restaurants",
                                cuisineSimilarity: "cuisineSimilarity",
                                metroSimilarity: "metroSimilarity",
                                featureWeights: featureWeights) {
            
            let liked = selectedCuisines
            
            let recommendations = recommender.getRecommendations(selectedCuisines: liked, topN: 30)
            
            let restaurantsOnly = recommendations.map { $0.restaurant }
            
            view?.showRestaurants(restaurantsOnly)
        }
    }
    
    func didTapBackButton() {
        router.goBack()
    }
    
    func didSelectRestaurant(_ restaurant: Restaurant) {
        router.showPlaceDetails(for: restaurant)
    }
}
