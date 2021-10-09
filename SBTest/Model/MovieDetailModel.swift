//
//  MovieDetailModel.swift
//  SBTest
//
//  Created by Stockbit on 06/08/21.
//

import Foundation

struct MovieDetailModel {
    
    struct Response {
        var movie: Movie
    }
    
    struct ViewModel {
        
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
        
        var subtitle: String? {
            return model.detail?.duration
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
        
        var about: NSAttributedString? {
            return model.detail?.description?.htmlToAttributedString
        }
    }
}
