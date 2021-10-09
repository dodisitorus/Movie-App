import UIKit

protocol IMoviesViewController: AnyObject {
    
    func displaySuccesGetMoviesList()
    
    func displaySuccesGetMoreMoviesList(list: [Movie])
    
    func displayFailedGetMoviesList()
    
    func showLoadingShimmerView()
    func hideLoadingShimmerView()
    
    func showLoadingMoreView()
    func hideLoadingMoreView()
}

class MovieListViewController: UIViewController {

    // MARK: Private
    private var interactor: IMovieListInteractor?
    private var router: IMovieListRouter?

    @IBOutlet weak var shimmerLoadingView: UIView!
    @IBOutlet weak var tableView: UITableView!

    private let movieCellIdentifier = "MovieCellViewIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        fetchMovie()
    }

    private func setup() {
        let presenter = MoviesListPresenter(view: self)
        self.interactor = MovieListInteractor(presenter: presenter, service: MovieService())
        
        self.router = MoviesListRouter(nav: self.navigationController)
        
        self.tableView.register(UINib(nibName: "MovieListTableViewCell", bundle: nil), forCellReuseIdentifier: self.movieCellIdentifier)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.setupRefreshControl(selector: #selector(self.refreshList), vc: self)
    }
    
    @objc func refreshList() {
        self.interactor?.fetchMovieList()
    }
    
    private func fetchMovie() {
        self.showLoadingShimmerView()
        self.interactor?.fetchMovieList()
    }
}

// MARK: - UITableViewDataSource

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.interactor?.getMoviesCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: self.movieCellIdentifier, for: indexPath) as? MovieListTableViewCell {
            
            cell.dataCell = self.interactor?.getMoviesViewModel()[indexPath.row]
            cell.updateView()
            
            return cell
        }
        
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let movie = self.interactor?.getMovie(on: indexPath.row) {
            self.router?.navigateDetail_Movie(movie: movie)
            tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        }
    }
}

// MARK: - UIScrollViewDelegate
extension MovieListViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if scrollView == self.tableView {
            
            let contentOffsetY = scrollView.contentOffset.y
            let scrollViewHeight = scrollView.frame.size.height
            let bottomEdge = contentOffsetY + scrollViewHeight
            let contentSizeHeight = self.tableView.contentSize.height - 10
            
            if (bottomEdge >= contentSizeHeight) && (self.interactor?.lastLength_result != 0) && (self.interactor?.isLoading == false) {
                
                self.interactor?.isLoading = true

                self.showLoadingMoreView()
                self.interactor?.getNextPage()
            }
        }
    }
}

// MARK: - IMoviesPresenter

extension MovieListViewController: IMoviesViewController {
    
    func displaySuccesGetMoviesList() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func displaySuccesGetMoreMoviesList(list: [Movie]) {
        DispatchQueue.main.async {
            // self.tableView.reloadData()
            
            let list: [Movie] = list

            for movie in list {

                self.tableView.performBatchUpdates({
                    
                    let lastItem: Int = self.interactor?.getMoviesCount() ?? 0
                    let indexPathN = IndexPath(item: lastItem, section: 0)

                    self.interactor?.appendMovie(movie)
                    
                    self.tableView.insertRows(at: [indexPathN], with: .bottom)
                }, completion: nil)
            }
        }
    }
    
    func displayFailedGetMoviesList() {
        self.showAlert(title: "Failed", message: "Something wrong, please reload again.")
    }
    
    func showLoadingShimmerView() {
        self.tableView.isHidden = true
        self.shimmerLoadingView.isHidden = false
    }
    
    func hideLoadingShimmerView() {
        DispatchQueue.main.async {
            self.tableView.isHidden = false
            self.shimmerLoadingView.isHidden = true
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    func showLoadingMoreView() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: self.tableView.bounds.width, height: CGFloat(44))

        self.tableView.tableFooterView = spinner
        self.tableView.tableFooterView?.isHidden = false
    }
    
    func hideLoadingMoreView() {
        DispatchQueue.main.async {
            self.tableView.tableFooterView?.isHidden = true
        }
    }
}
