import Foundation
import UIKit

protocol MovieDetailsDelegate{
    var movieDetails: Movie { get set }
}

class MovieDetailsViewController: UIViewController{
    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var GenresLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var playtimeLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    
    var movieDetailsDelegate: MovieDetailsDelegate!
    var movieDetails: Movie?
    
    func generateRatingStars(stars: Int) -> String{
        var ratingStars = "";
        for _ in 0..<stars{
            ratingStars += "★";
        }
        for _ in 0..<5-stars{
            ratingStars += "☆"
        }
        return ratingStars
    }
    
    override func viewDidLoad() {
        
        titleLabel.text = movieDetails?.name
        playtimeLabel.text = String(movieDetails?.runtime ?? 0) + " min"
        overviewTextView.text = movieDetails?.overview
        
        let genres = movieDetails?.genres?.map{ $0.name! }
        GenresLabel.text = genres?.joined(separator: ", ")
        
        let rating:Int = Int((movieDetails?.voteAverage ?? 0) / 2)
        ratingLabel.text = generateRatingStars(stars: rating)
        
        var backdropUrl = Constans.backdropBaseUrl
        backdropUrl.appendPathComponent(movieDetails!.backdropUrl)
        
        backdropImageView.kf.setImage(with: backdropUrl, options: [
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage
        ])
        backdropImageView.contentMode = .scaleToFill;
    }
    @IBAction func closeButtonTouch() {
        dismiss(animated: true, completion: nil)
    }
}
