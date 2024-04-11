
import Foundation

struct Proudct: Codable {
    let products: [ProductList]
    let total, skip, limit: Int
}

// MARK: - Product
struct ProductList: Codable {
    let id: Int
    let title, description: String
    var price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
}
