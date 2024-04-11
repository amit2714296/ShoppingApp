

import Foundation
import UIKit


extension ProductDetailVC :  UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.productDetailCell, for: indexPath) as? ProductDetailCell else { return ProductDetailCell() }
        
        switch indexPath.row {
        case 0:
            
            cell.item = "Brand: " + (self.productDetail?.brand ?? "")
            return cell
        case 1:
            cell.item = "Category: " + (self.productDetail?.category ?? "")
            return cell
        case 2:
            cell.item = "Title: " + (self.productDetail?.title ?? "")
            return cell
        case 3:
            cell.item = "Description: " + (self.productDetail?.description ?? "")
            return cell
        case 4:
            cell.item = "Price: " + "\(self.productDetail?.price ?? 0)"
            return cell
        case 5:
            cell.item = "Rating: " + "\(self.productDetail?.rating ?? 0)"
            return cell
        default:
            return  UITableViewCell()
        }
    }
}
