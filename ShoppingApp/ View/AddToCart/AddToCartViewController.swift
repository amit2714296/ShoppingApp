
import UIKit

class AddToCartViewController: UIViewController {
    
    private var cardViewModel: AddToCartViewModel?
    @IBOutlet weak var tableView : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Cart"
        self.tableView.register(UINib(nibName: Constant.addToCartCell, bundle: nil), forCellReuseIdentifier: Constant.addToCartCell)
        cardViewModel = AddToCartViewModel(manager: ProductStorageManager())
        cardViewModel?.prepareData()
        tableView.reloadData()
    }
}

extension AddToCartViewController :  UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardViewModel?.addToCartProductCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.addToCartCell, for: indexPath) as? AddToCartTableViewCell else { return AddToCartTableViewCell() }
        cell.cardList = cardViewModel?.geProduct(index: indexPath.row)
        return cell
    }
}

