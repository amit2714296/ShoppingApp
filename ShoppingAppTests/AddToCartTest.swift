
import XCTest
@testable import ShoppingApp

final class AddToCartTest: XCTestCase {

    var addToCartViewModel: AddToCartViewModel!
    var addToCartViewController: AddToCartViewController!

    override func setUpWithError() throws {
        addToCartViewModel = AddToCartViewModel(manager: ProductStorageManager())
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.addToCartViewController = storyboard.instantiateViewController(withIdentifier: "AddToCartViewController") as? AddToCartViewController
        
        self.addToCartViewController.loadView()
        self.addToCartViewController.viewDidLoad()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        addToCartViewModel =  nil
        addToCartViewController = nil
    }
    
    func test_addToCardDataCount() {
        addToCartViewModel.cartData.append(ProductList(id: 1, title: "iphone", description: "test", price: 3435, discountPercentage: 45, rating: 3, stock: 4, brand: "Apple", category: "Phone", thumbnail: "https://test", images: []))
        
        XCTAssertEqual(addToCartViewModel.addToCartProductCount(), 1)
    }
    
    func testTableViewCellHasReuseIdentifier() {
        let cell = addToCartViewController.tableView(addToCartViewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? AddToCartTableViewCell
        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = "AddToCartTableViewCell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }
    
    func testTableCellHasCorrectLabelText() {
        let cell = addToCartViewController.tableView(addToCartViewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? AddToCartTableViewCell
        cell?.cardList?.price =  234
        XCTAssertEqual(cell?.lblPrice.text, "Price: 234")
    }

}
