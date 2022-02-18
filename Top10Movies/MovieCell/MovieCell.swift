import UIKit
import Kingfisher
import SwiftUI

@IBDesignable
class MovieCell: UITableViewCell {

    @IBOutlet weak var backdropImageView: UIImageView!
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var cellViewModel: Movie? {
        didSet {
            
            var backdropUrl = Constans.backdropBaseUrl
            backdropUrl.appendPathComponent(cellViewModel!.backdropUrl)
            
            backdropImageView.kf.indicatorType = .activity
            backdropImageView.kf.setImage(with: backdropUrl, options: [
                .processor(RoundCornerImageProcessor(cornerRadius: 10)),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
             
        }
    }

}
