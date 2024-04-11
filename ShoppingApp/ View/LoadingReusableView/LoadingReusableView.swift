
import UIKit

class LoadingReusableView: UICollectionReusableView {

   @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.color = UIColor.gray
    }
}
