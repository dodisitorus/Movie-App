//
//  MoviesListRouter.swift
//  SBTest
//
//  Created by Dodi Sitorus on 08/10/21.
//

import Foundation
import UIKit

protocol IMovieListRouter {
    
    func navigateDetail_Movie(movie: Movie)
}

class MoviesListRouter: IMovieListRouter {
    
    // MARK: Private
    private weak var navController: UINavigationController?
    
    init(nav: UINavigationController?) {
        self.navController = nav
    }

    func navigateDetail_Movie(movie: Movie) {
        let controller = MovieDetailViewController(movie: movie)
        self.navController?.pushViewController(controller, animated: true)
    }
}
