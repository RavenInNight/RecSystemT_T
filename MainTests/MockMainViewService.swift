import Foundation
import UIKit

class MockMainViewService: MainViewInput {
    var getNextColorCalled = false
    var nextColorToReturn: UIColor = .red
    
    func getNextColor() -> UIColor {
        getNextColorCalled = true
        return nextColorToReturn
    }
}
