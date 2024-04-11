

import UIKit

class ProductDetailVC: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    
    var productDetail: ProductList?
    private var productManager: ProductStorageManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Product Detail"
        tableView.register(UINib(nibName: Constant.productDetailCell, bundle: nil), forCellReuseIdentifier: Constant.productDetailCell)
        tableView.reloadData()
        productManager = ProductStorageManager()
    }
    
    @IBAction func addToCartButton(sender: UIButton) {
        guard let getSelectedProductDetail = self.productDetail else {
            return
        }
        productManager.insert(getProduct: getSelectedProductDetail)
        
        presentAlertWithTitle(title: "", message: Constant.CartAdded, options: "Ok") { (option) in
            switch(option) {
            case "Ok":
                self.navigationController?.popViewController(animated: true)
                break
            default:
                break
            }
        }
    }
}

