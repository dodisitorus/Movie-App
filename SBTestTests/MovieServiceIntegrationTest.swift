
import Foundation
import XCTest
@testable import SBTest

class MovieServiceIntegrationTest: XCTestCase {
    
    func testHitAPIrequestMovieList() {
        let service: IMovieService = MovieService()
        
        let expectationResult = expectation(description: "request api of movies")
        
        service.requestMovieList { result in
            expectationResult.fulfill()
        }
        
        // request time very long! 15s - 20s
        waitForExpectations(timeout: 20)
    }
    
}
