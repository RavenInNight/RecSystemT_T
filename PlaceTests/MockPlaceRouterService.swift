import Foundation

class MockPlaceRouterService: PlaceRouterInput {
    var goBackCalled = false
    
    func goBack() {
        goBackCalled = true
    }
}
