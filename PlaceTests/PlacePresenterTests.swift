import XCTest
@testable import RESTaurant

final class PlacePresenterTests: XCTestCase {
    
    private var sut: PlacePresenter!
    private var viewMock: MockPlaceViewService!
    private var routerMock: MockPlaceRouterService!
    var testRestaurant: Restaurant!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        testRestaurant = Restaurant.mock()
        routerMock = MockPlaceRouterService()
        viewMock = MockPlaceViewService()
        sut = PlacePresenter(router: routerMock, restaurant: testRestaurant)
        sut.view = viewMock
    }

    override func tearDownWithError() throws {
        routerMock = nil
        viewMock = nil
        testRestaurant = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func testViewDidLoad() {
        // given
        
        // when
        sut.viewDidLoad()
            
        // then
        XCTAssertTrue(viewMock.showRestaurantDetailsCalled)
        XCTAssertEqual(viewMock.shownRestaurant?.name, testRestaurant.name)
        XCTAssertEqual(viewMock.shownRestaurant?.address, testRestaurant.address)
        XCTAssertEqual(viewMock.shownRestaurant?.cuisine, testRestaurant.cuisine)
    }
    
    func testRouterGoBack() {
        // given
        
        // when
        routerMock.goBack()
            
        // then
        XCTAssertTrue(routerMock.goBackCalled)
    }


}
