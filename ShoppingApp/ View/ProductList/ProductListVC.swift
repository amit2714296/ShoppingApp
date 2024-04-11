
import UIKit

class ProductListVC: UIViewController, ProducListProtocol {
    
    @IBOutlet weak var productCollectionView : UICollectionView!
    @IBOutlet weak var lblCart: UILabel!
    
    var productListData: [ProductList] = []
    var isLoading = false
    var loadingView: LoadingReusableView?
    var count = 0
    private let manager = ProductStorageManager()
    
    lazy var viewModel : ProductViewModel = {
        let viewModel = ProductViewModel(service: ProductService.shared)
        return viewModel
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        lblCart.text = manager.fetchData().count.description
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        lblCart.layer.cornerRadius = lblCart.frame.size.height/2.0
        lblCart.layer.masksToBounds = true
        
        self.viewModel.onErrorHandling = { [weak self] error in
            // display error ?
            let controller = UIAlertController(title: "An error occured", message: "Oops, something went wrong!", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self?.present(controller, animated: true, completion: nil)
        }
        
        registerNib()
        self.viewModel.fetchProductList(skip: count)
    }
    
    func registerNib() {
        // Register Loading Reuseable View
        let loadingReusableNib = UINib(nibName: Constant.loadingReusableView, bundle: nil)
        productCollectionView.register(loadingReusableNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: Constant.loadingresuableviewid)
    }
    
    func getProductListData(data: [ProductList]) {
        isLoading = false
        productListData.append(contentsOf: data)
        self.productCollectionView.reloadData()
    }
    
    @IBAction func goToAddScreen(_sender: AnyObject) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let addToCartViewController = storyBoard.instantiateViewController(withIdentifier: Constant.addToCartViewController) as? AddToCartViewController else { return }
        navigationController?.pushViewController(addToCartViewController, animated: true)
    }
    
}
