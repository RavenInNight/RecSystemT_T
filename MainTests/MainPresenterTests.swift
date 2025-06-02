import XCTest
@testable import RESTaurant

final class MainPresenterTests: XCTestCase {
    
    private var sut: MainPresenter!
    private var viewMock: MockMainViewService!
    private var routerMock: MockMainRouterService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        routerMock = MockMainRouterService()
        viewMock = MockMainViewService()
        sut = MainPresenter(router: routerMock)
        sut.view = viewMock
    }

    override func tearDownWithError() throws {
        routerMock = nil
        viewMock = nil
        sut = nil
        try super.tearDownWithError()
    }

    func testDidSelectCuisines() {
        // given
        let testCuisines = ["Русская", "Итальянская"]
        
        //when
        sut.didSelectCuisines(testCuisines)
        
        //then
        XCTAssertTrue(routerMock.showResultsCalled)
        XCTAssertEqual(routerMock.showResultsCuisines, testCuisines)
        
    }

}
