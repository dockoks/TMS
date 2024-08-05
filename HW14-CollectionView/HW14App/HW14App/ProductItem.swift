import UIKit

struct ProductItem {
    let icon: UIImage
    let model: String
    let color: UIColor
}

struct ProductSection {
    let title: String
    let items: [ProductItem]
}
