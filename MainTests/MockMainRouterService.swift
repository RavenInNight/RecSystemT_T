import Foundation

class MockMainRouterService: MainRouterInput {
    var showResultsCalled = false
        var showResultsCuisines: [String]?
        var goBackCalled = false
        
        func showResults(for cuisines: [String]) {
            showResultsCalled = true
            showResultsCuisines = cuisines
        }
        
        func goBack() {
            goBackCalled = true
        }
}
