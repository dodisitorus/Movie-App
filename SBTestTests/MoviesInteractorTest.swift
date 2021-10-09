import XCTest
@testable import SBTest

class MoviesInteractorTest: XCTestCase {
    
    func testSuccessFetchMovie() {
        let service: IMovieService = MovieService()
        
        let expectationResult = expectation(description: "success fetch movies")
        
        service.requestMovieList { result in
            switch result {
            case .success(_):
                expectationResult.fulfill()
            case .failure(_):
                break
            }
        }
        
        // request time very long! 15s - 20s
        waitForExpectations(timeout: 20)
    }
    
    func testFailureFetchMovie() {
        let service: IMovieService = MovieService()
        
        let expectationResult = expectation(description: "failure fetch movies")
        
        // page for 893 and higher
        service.loadMoreMovies(page: 893) { result in
            switch result {
            case .success(let list):
                if list.result?.count == 0 {
                    expectationResult.fulfill()
                }
            case .failure(_):
                expectationResult.fulfill()
            }
        }
        
        // request time very long! 15s - 20s
        waitForExpectations(timeout: 20)
    }
    
    func testAssertData() {
        let service: IMovieService = MovieService()
        
        let expectationResult = expectation(description: "assert not nil movies")
        var movies: [Movie]?
        
        service.requestMovieList { result in
            switch result {
            case .success(let list):
                movies = list.result
                expectationResult.fulfill()
            case .failure(_):
                break
            }
        }
        
        // request time very long! 15s - 20s
        waitForExpectations(timeout: 20) { error in
            XCTAssertNotNil(movies)
        }
    }
}
