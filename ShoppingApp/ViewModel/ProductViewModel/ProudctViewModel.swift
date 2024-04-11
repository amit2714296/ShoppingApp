
import Foundation

protocol ProducListProtocol {
    func getProductListData(data:[ProductList])
}

struct ProductViewModel {
    
    weak var service: ProductServiceProtocol?
    var delegate: ProducListProtocol?
    var onErrorHandling : ((ErrorResult?) -> Void)?
    
    init(service: ProductServiceProtocol) {
        self.service = service
    }
    
    func fetchProductList(skip: Int) {
        
        guard let service = service else {
            onErrorHandling?(ErrorResult.custom(string: "Missing service"))
            return
        }
        
        service.fetchProductList(skip: skip) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let product) :
                    delegate?.getProductListData(data: product.products)
                case .failure(let error) :
                    self.onErrorHandling?(error)
                }
            }
        }
    }
    
    
}
