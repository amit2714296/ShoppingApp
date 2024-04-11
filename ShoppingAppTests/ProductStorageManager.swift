
import XCTest
import CoreData
@testable import ShoppingApp

final class ProductStorageManagerTests: XCTestCase {

    var mockStorageManager: ProductStorageManager!
    var saveNotificationCompleteHandler: ((Notification)->())?
    
    //MARK: mock in-memory persistant store
    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
        return managedObjectModel
    }()
    
    lazy var mockPersistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ShoppingApp", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false // Make it simpler in test env
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )
            
            // Check if creating container wrong
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        return container
    }()
    
    override func setUp() {
        initStubs()
        mockStorageManager = ProductStorageManager(container: mockPersistantContainer)
        
        //Listen to the change in context
        NotificationCenter.default.addObserver(self, selector: #selector(contextSaved(notification:)), name: NSNotification.Name.NSManagedObjectContextDidSave , object: nil)
    }
    
    override func tearDown() {
        NotificationCenter.default.removeObserver(self)
        flushData()
        super.tearDown()
    }
    
    func test_add_Product() {
        // Given
       let productList =  ProductList(id: 1, title: "test", description: "Test", price: 54, discountPercentage: 45.3, rating: 45, stock: 6, brand: "apple", category: "mobile", thumbnail: "www", images: ["image"])
        // When
        let productNew: () =  mockStorageManager.insert(getProduct: productList)
        
        // Then
        XCTAssertNotNil(productNew)
    }
    
    func test_fetch_all_product() {
        // Given
        
        // When
        let results = mockStorageManager.fetchData()
        
        // Then
        XCTAssertEqual(results.count, 2)
    }
    
    func test_remove_Product() {
        // Given
        let items = mockStorageManager.fetchData()
        let item = items[0]
        
        let numberOfItems = items.count
        
        // When
        mockStorageManager.remove(objectID: item.objectID)
        mockStorageManager.save()
        
        // Then
        XCTAssertEqual(numberOfItemsInPersistentStore(), numberOfItems-1)
    }
}


extension ProductStorageManagerTests {
    
    //MARK: Convinient function for notification
    func expectationForSaveNotification() -> XCTestExpectation {
        let expect = expectation(description: "Context Saved")
        waitForSavedNotification { (notification) in
            expect.fulfill()
        }
        return expect
    }
    
    func waitForSavedNotification(completeHandler: @escaping ((Notification)->()) ) {
        saveNotificationCompleteHandler = completeHandler
    }
    
    func contextSaved( notification: Notification ) {
        print("\(notification)")
        saveNotificationCompleteHandler?(notification)
    }
    
    func  insert(getProduct: ProductList) -> ProductData? {
        
        let obj = NSEntityDescription.insertNewObject(forEntityName: "ProductData", into: mockPersistantContainer.viewContext)
        obj.setValue(getProduct.brand, forKey: "brand")
        obj.setValue(getProduct.price, forKey: "price")
        
        return obj as? ProductData
    }
    
    //MARK: Creat some fakes
    func initStubs() {
        
        let productList =  ProductList(id: 1, title: "test", description: "Test", price: 54, discountPercentage: 45.3, rating: 45, stock: 6, brand: "apple", category: "dff", thumbnail: "www", images: ["image"])
        let productList2 =  ProductList(id: 1, title: "test", description: "Test", price: 54, discountPercentage: 45.3, rating: 45, stock: 6, brand: "apple", category: "dff", thumbnail: "www", images: ["image"])
        _ = insert(getProduct: productList)
        _ = insert(getProduct: productList2)
        
        do {
            try mockPersistantContainer.viewContext.save()
        }  catch {
            print("create fakes error \(error)")
        }
        
    }
    
    func flushData() {
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductData")
        let objs = try! mockPersistantContainer.viewContext.fetch(fetchRequest)
        for case let obj as NSManagedObject in objs {
            mockPersistantContainer.viewContext.delete(obj)
        }
        
        try! mockPersistantContainer.viewContext.save()
    }
    
    func numberOfItemsInPersistentStore() -> Int {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "ProductData")
        let results = try! mockPersistantContainer.viewContext.fetch(request)
        return results.count
    }
    
}
