import Foundation

struct MovieListModel {
    
    struct ViewModel {
        
        let movieItem: MovieItem
        
        init(movie: Movie) {
            self.movieItem = MovieItem(movie: movie)
        }
        
        struct MovieItem {
            
            private let model: Movie
            
            init(movie: Movie) {
                self.model = movie
            }
            
            var thumbnail: URL? {
                return URL(string: model.thumbnailPotrait ?? "")
            }
            
            var title: String? {
                return model.title
            }
            
            var desc: NSAttributedString? {
                return model.detail?.description?.htmlToAttributedString
            }
            
            var rating: String? {
                return model.rating
            }
            
            var ratingNumber: Double? {
                return Double(model.rating ?? "0")
            }
            
            var genre: String? {
                return model.detail?.genre
            }

            var about: String? {
                return model.detail?.description
            }
        }
    }
}
