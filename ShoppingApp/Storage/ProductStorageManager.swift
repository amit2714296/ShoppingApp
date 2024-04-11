

import Foundation
import UIKit
import CoreData

class ProductStorageManager : StorageManager {
    
    //MARK: Function
    func fetchData() -> [ProductData] {
        let request: NSFetchRequest<ProductData> = ProductData.fetchRequest()
        let results = try? persistentContainer.viewContext.fetch(request)
        return results ?? [ProductData]()
    }
    
    func insert(getProduct: ProductList) {
        guard let ProductData = NSEntityDescription.insertNewObject(forEntityName: "ProductData", into: backgroundContext) as? ProductData else { return  }
        ProductData.brand = getProduct.brand
        ProductData.name = getProduct.title
        ProductData.price = Double(getProduct.price)
        ProductData.img = getProduct.thumbnail
        self.save()
    }
    
    func remove( objectID: NSManagedObjectID ) {
        let obj = backgroundContext.object(with: objectID)
        backgroundContext.delete(obj)
    }
    
    func save() {
        if backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
            } catch {
                print("Save error \(error)")
            }
        }
    }
    
}
