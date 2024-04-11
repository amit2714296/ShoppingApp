
import XCTest
@testable import ShoppingApp

final class ProductDetailsTestCases: XCTestCase {
    
    var productDetailsController: ProductDetailVC!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.productDetailsController = storyboard.instantiateViewController(withIdentifier: "ProductDetailVC") as? ProductDetailVC
        
        self.productDetailsController.loadView()
        self.productDetailsController.viewDidLoad()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        productDetailsController = nil
    }
    
    func testHasATableView() {
        XCTAssertNotNil(productDetailsController.tableView)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(productDetailsController.tableView.delegate)
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(productDetailsController.tableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(productDetailsController.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(productDetailsController.responds(to: #selector(productDetailsController.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(productDetailsController.responds(to: #selector(productDetailsController.tableView(_:cellForRowAt:))))
    }
    
    func testTableViewCellHasReuseIdentifier() {
        let cell = productDetailsController.tableView(productDetailsController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? ProductDetailCell
        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = "ProductDetailCell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }
    
    func testTableCellHasCorrectLabelText() {
        let cell = productDetailsController.tableView(productDetailsController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? ProductDetailCell
        cell?.item = "Brand: " + "Apple"
        XCTAssertEqual(cell?.lblProductName.text, "Brand: Apple")
    }
}
