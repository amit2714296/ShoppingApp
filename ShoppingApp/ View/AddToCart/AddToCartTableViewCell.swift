

import UIKit

class AddToCartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDisc: UILabel!
    @IBOutlet weak var imgThumbnil: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var cardList: ProductList? {
        didSet {
            guard let cardListData = cardList else { return }
            lblTitle.text = "Product Name: " + cardListData.title.description
            lblPrice.text = "Price: " + cardListData.price.description
            lblDisc.text = "Brand: " + cardListData.brand
            imgThumbnil.loadImageUsingCache(withUrl: cardListData.thumbnail)
        }
    }
}
