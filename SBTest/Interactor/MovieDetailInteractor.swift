//
//  MovieDetailInteractor.swift
//  SBTest
//
//  Created by Stockbit on 06/08/21.
//

import Foundation

protocol IMovieDetailInteractor: AnyObject {
    func handleMovieDetail()
    
    func getMovieDetail() -> Movie
}

class MovieDetailInteractor: IMovieDetailInteractor {
    private var presenter: IMovieDetailPresenter?
    private var movie: Movie
    
    init(presenter: IMovieDetailPresenter, movie: Movie) {
        self.presenter = presenter
        self.movie = movie
    }
    
    func handleMovieDetail() {
        let response = MovieDetailModel.Response(movie: movie)
        presenter?.presentMovieDetail(response: response)
    }
    
    func getMovieDetail() -> Movie {
        return self.movie
    }
}
