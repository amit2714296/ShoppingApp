
import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var img : UIImageView!
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var lblPrice : UILabel!
    @IBOutlet weak var lblDisc : UILabel!

    var product : ProductList? {
        didSet {
            guard let getProduct = product else {
                return
            }
            
            lblName?.text = "\(getProduct.title)"
            lblPrice?.text = "₹ \(getProduct.price)"
            lblDisc?.text = "\(getProduct.discountPercentage)% off"
            img.loadImageUsingCache(withUrl: getProduct.thumbnail)
        }
    }
}
