

import Foundation
import UIKit

extension UIViewController {

    func presentAlertWithTitle(title: String, message: String, options: String..., completion: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                completion(options[index])
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }
}

struct Constant {
    static let addToCartCell = "AddToCartTableViewCell"
    static let addToCartViewController = "AddToCartViewController"
    static let productDetailVC = "ProductDetailVC"
    static let loadingReusableView = "LoadingReusableView"
    static let loadingresuableviewid = "loadingresuableviewid"
    static let productCollectionViewCell = "ProductCollectionViewCell"
    static let productDetailCell = "ProductDetailCell"
    static let CartAdded = "Cart added successfully"
}



