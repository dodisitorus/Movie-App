
import Foundation

struct MovieList: Codable {
    var result: [Movie]?
    var length, page: String?
}

struct Movie: Codable {
    var title: String?
    var thumbnailPotrait: String?
    var rating: String?
    var quality: String?
    var movieID: String?
    var detail: Detail?
}

struct Detail: Codable {
    var views, genre, director, actors: String?
    var country, duration: String?
    var release: String?
    var thumbnailLandscape: String?
    var description: String?
    var trailer: String?
}
