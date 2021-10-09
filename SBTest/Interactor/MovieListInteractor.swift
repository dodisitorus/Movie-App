import Foundation

protocol IMovieListInteractor {
    
    var lastPage: Int { get set }
    var moviesViewModel: [MovieListModel.ViewModel.MovieItem]? { get set }
    var movies: [Movie]? { get set }
    var lastLength_result: Int { get set }
    var isLoading: Bool { get set }
    
    func fetchMovieList()
    func getNextPage()
    
    func getMoviesCount() -> Int
    func getMoviesViewModel() -> [MovieListModel.ViewModel.MovieItem]
    func getMoviesEntity() -> [Movie]
    func getMovie(on index: Int) -> Movie?
    
    func appendMovie(_ movie: Movie)
    
}

class MovieListInteractor: IMovieListInteractor {
    
    // MARK: Private
    private let service: IMovieService
    private var presenter: IMoviesPresenter
    
    var lastPage: Int = 1
    var movies: [Movie]?
    var moviesViewModel: [MovieListModel.ViewModel.MovieItem]?
    var lastLength_result: Int = 0
    var isLoading: Bool = false
    
    // MARK: Lifecycle
    
    init(presenter: IMoviesPresenter, service: IMovieService) {
        self.presenter = presenter
        self.service = service
    }

    // MARK: Internal

    func fetchMovieList() {
        self.isLoading = true
        self.lastPage = 1
        self.service.requestMovieList { result in
            self.isLoading = false
            switch result {
            case .success(let list):
                self.movies = list.result
                self.lastLength_result = Int(list.length ?? "0") ?? 0
                self.presenter.presentSuccessGetMovieList()
            case .failure(let err):
                self.presenter.requestFailedGetMovieList(message: err.localizedDescription)
            }
        }
    }
    
    func getMoviesEntity() -> [Movie] {
        return self.movies ?? []
    }

    func getMoviesCount() -> Int {
        return self.movies?.count ?? 0
    }
    
    func getMoviesViewModel() -> [MovieListModel.ViewModel.MovieItem] {
        
        var list: [MovieListModel.ViewModel.MovieItem] = []
        
        for item in self.getMoviesEntity() {
            let viewModelMovie = MovieListModel.ViewModel(movie: item)
            list.append(viewModelMovie.movieItem)
        }
        
        return list
    }

    func getMovie(on index: Int) -> Movie? {
        if index < self.getMoviesCount() {
            return self.getMoviesEntity()[index]
        }
        return nil
    }

    func appendMovie(_ movie: Movie) {
        self.movies?.append(movie)
    }
    
    func getNextPage() {
        self.isLoading = true
        self.service.loadMoreMovies(page: self.lastPage + 1) { result in
            self.isLoading = false
            switch result {
            case .success(let list):
                // self.movies = list.result
                self.lastLength_result = Int(list.length ?? "0") ?? 0
                self.lastPage += 1
                self.presenter.presentSuccessGetMoreMovieList(list: list.result ?? [])
            case .failure(let err):
                self.presenter.requestFailedGetMovieList(message: err.localizedDescription)
            }
        }
    }
}
