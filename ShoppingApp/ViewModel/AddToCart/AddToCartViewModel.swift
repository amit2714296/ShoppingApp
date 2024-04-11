
import Foundation

class AddToCartViewModel {
    
    private var manager: ProductStorageManager!
    var cartData: [ProductList] = []
    
    init(manager: ProductStorageManager) {
        self.manager = manager
    }
    
    func prepareData() {
        let getData = self.manager.fetchData()
        
        getData.forEach({ data in
            cartData.append( ProductList(id: Int(bitPattern: data.id), title: data.name ?? "", description: "", price: Int(data.price), discountPercentage: 0.0, rating: 0.0, stock: 0, brand: data.brand ?? "", category: "", thumbnail: data.img ?? "", images: []))
        })
    }
    
    func addToCartProductCount() -> Int {
        self.cartData.count
    }
    
    func  geProduct(index: Int) -> ProductList {
        cartData[index]
    }
}
