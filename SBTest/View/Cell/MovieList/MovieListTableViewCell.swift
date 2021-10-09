//
//  MovieListTableViewCell.swift
//  SBTest
//
//  Created by Stockbit on 06/08/21.
//

import UIKit
import Kingfisher

final class MovieListTableViewCell: UITableViewCell {
    
    static let p = ResizingImageProcessor(referenceSize: .init(width: 200, height: CGFloat.infinity), mode: .aspectFit)
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    @IBOutlet weak var star_1: UIImageView!
    @IBOutlet weak var star_2: UIImageView!
    @IBOutlet weak var star_3: UIImageView!
    @IBOutlet weak var star_4: UIImageView!
    @IBOutlet weak var star_5: UIImageView!
    
    var dataCell: MovieListModel.ViewModel.MovieItem?
    
    private var starRating: IStarRating = StarRating()
    
    func updateView() {
        
        if let movie = self.dataCell {
            if let url = movie.thumbnail {
                
                self.thumbnail.contentMode = .scaleAspectFill
                
                DispatchQueue.main.async {
                    self.thumbnail.kf.setImage(with: url, placeholder: .none, options: [
                        .processor(MovieListTableViewCell.p),
                        .transition(.fade(1)),
                        .scaleFactor(self.thumbnail.contentScaleFactor)
                    ], completionHandler: nil)
                }
                
                self.title.text = movie.title
                self.rating.text = "\(movie.ratingNumber ?? 0.0)"
                self.date.text = movie.genre // not found value for date
                self.desc.attributedText = movie.desc
                
                if let rating = movie.ratingNumber {
                    self.starRating.listImageStar = [star_1, star_2, star_3, star_4, star_5]
                    self.starRating.setColor(value: rating)
                }
            }
        }
    }
}
