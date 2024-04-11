

import XCTest
@testable import ShoppingApp

final class ShoppingAppTests: XCTestCase {
    
    var viewModel : ProductViewModel!
    fileprivate var service : MockProductService!
    
    override func setUpWithError() throws {
        self.service = MockProductService()
        self.viewModel = ProductViewModel(service: service)
    }

    override func tearDownWithError() throws {
        self.viewModel = nil
        self.service = nil
    }

    func testFetchProduct() {
        
        let expectation = XCTestExpectation(description: "Product fetch")
        
        // giving a service mocking currencies
        service.proudct = Proudct(products: [ProductList(id: 1, title: "test", description: "ds", price: 5, discountPercentage: 4.5, rating: 5, stock: 3, brand: "apple", category: "test", thumbnail: "dsdsfd", images: [])], total: 6, skip: 4, limit: 3)
        
        viewModel.onErrorHandling = { _ in
            XCTAssert(false, "ViewModel should not be able to fetch without service")
        }
        
        
        service.fetchProductList(skip: 0) { result in
            switch result {
            case .success(_) :
                expectation.fulfill()
            case .failure(_) :
                break
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    
    func testProductFetchWithNoService() {
        
        let expectation = XCTestExpectation(description: "No service Product")
        
        // giving no service to a view model
        viewModel.service = nil
        
        // expected to not be able to fetch product
        viewModel.onErrorHandling = { error in
            expectation.fulfill()
        }
        
        viewModel.fetchProductList(skip: 0)
        wait(for: [expectation], timeout: 5.0)
    }

}

fileprivate class MockProductService : ProductServiceProtocol {
    
    var proudct : Proudct?

    func fetchProductList(skip: Int, _ completion: @escaping ((Result<Proudct, ErrorResult>) -> Void)) {

        if let getProudct = proudct {
            completion(Result.success(getProudct))
        } else {
            completion(Result.failure(ErrorResult.custom(string: "No Data")))
        }
    }
}

