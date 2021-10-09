import UIKit

protocol IMovieDetailViewController: AnyObject {
    
    func displayMovieDetail(viewModel: MovieDetailModel.ViewModel)
}

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var star_1: UIImageView!
    @IBOutlet weak var star_2: UIImageView!
    @IBOutlet weak var star_3: UIImageView!
    @IBOutlet weak var star_4: UIImageView!
    @IBOutlet weak var star_5: UIImageView!
    
    private var interactor: IMovieDetailInteractor!
    
    private var starRating: IStarRating = StarRating()
    
    convenience init(movie: Movie) {
        let bundle = Bundle(for: type(of: self))
        self.init(nibName: "MovieDetailViewController", bundle: bundle)
        setup(movie: movie)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.interactor.handleMovieDetail()
    }
    
    private func setup(movie: Movie) {
        let presenter = MovieDetailPresenter(view: self)
        interactor = MovieDetailInteractor(presenter: presenter, movie: movie)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func onPlay_Movie(_ sender: Any) {
        if let url = URL(string: self.interactor.getMovieDetail().detail?.trailer ?? "") {
            UIApplication.shared.open(url, options: [:]) { (respone) in
                print(respone)
            }
        }
    }
    
    @IBAction func onClose_screen(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension MovieDetailViewController: IMovieDetailViewController {
    
    func displayMovieDetail(viewModel: MovieDetailModel.ViewModel) {
        
        self.thumbnail.contentMode = .scaleAspectFill
        
        DispatchQueue.main.async {
            self.thumbnail.kf.setImage(with: viewModel.thumbnail, placeholder: .none, options: [.transition(.fade(1))], completionHandler: nil)
        }
        
        self.titleLabel.text = viewModel.title
        self.subTitleLabel.text = viewModel.subtitle
        self.ratingLabel.text = viewModel.rating
        self.genreLabel.text = viewModel.genre
        self.aboutLabel.attributedText = viewModel.about
        
        if let rating = viewModel.ratingNumber {
            self.starRating.listImageStar = [star_1, star_2, star_3, star_4, star_5]
            self.starRating.setColor(value: rating)
        }
    }
}
