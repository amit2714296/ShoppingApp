

import Foundation

protocol ProductServiceProtocol : AnyObject {
    func fetchProductList(skip: Int, _ completion: @escaping ((Result<Proudct, ErrorResult>) -> Void))
}

protocol API {
    static var baseUrl:String { get }
}

enum APIS {
    enum productList: API {
        static var baseUrl = "https://dummyjson.com/products?limit=10&skip="
    }
}

final class ProductService : RequestHandler, ProductServiceProtocol {
    
    static let shared = ProductService()
    
    var endpoint = ""
    var task : URLSessionTask?
    
    func fetchProductList(skip: Int, _ completion: @escaping ((Result<Proudct, ErrorResult>) -> Void)) {
        self.endpoint = APIS.productList.baseUrl + "\(skip)"
        // cancel previous request if already in progress
        self.cancelFetchCurrencies()
        
        task = RequestService().loadData(urlString: endpoint, completion: self.networkResult(completion: completion))
    }
    
    func cancelFetchCurrencies() {
        
        if let task = task {
            task.cancel()
        }
        task = nil
    }
}
