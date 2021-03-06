//
//  MovieDetailPresenter.swift
//  MovieDetailPresenter
//
//  Created by Ari Munandar on 06/08/21.
//

import Foundation

protocol IMovieDetailPresenter: AnyObject {
    func presentMovieDetail(response: MovieDetailModel.Response)
}

class MovieDetailPresenter: IMovieDetailPresenter {
    private var view: IMovieDetailViewController?
    
    init(view: IMovieDetailViewController) {
        self.view = view
    }
    
    func presentMovieDetail(response: MovieDetailModel.Response) {
        let viewModel = MovieDetailModel.ViewModel(movie: response.movie)
        view?.displayMovieDetail(viewModel: viewModel)
    }
}
