//
//  MoviesPresenter.swift
//  SBTest
//
//  Created by Stockbit on 06/08/21.
//

import Foundation

protocol IMoviesPresenter {
    
    func presentSuccessGetMovieList()
    func presentSuccessGetMoreMovieList(list: [Movie])
    
    func requestFailedGetMovieList(message: String)
}

class MoviesListPresenter: IMoviesPresenter {
    
    // MARK: Private
    private weak var view: IMoviesViewController?
    
    init(view: IMoviesViewController) {
        self.view = view
    }

    // MARK: Internal

    func presentSuccessGetMovieList() {
        view?.hideLoadingShimmerView()
        view?.displaySuccesGetMoviesList()
    }
    
    func presentSuccessGetMoreMovieList(list: [Movie]) {
        view?.hideLoadingMoreView()
        view?.displaySuccesGetMoreMoviesList(list: list)
    }
    
    func requestFailedGetMovieList(message: String) {
        view?.displayFailedGetMoviesList()
    }
}
