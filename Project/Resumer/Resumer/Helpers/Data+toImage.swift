import SwiftUI
import UIKit

extension Data {
    func toImage() -> Image? {
        guard let uiImage = UIImage(data: self) else { return nil }
        return Image(uiImage: uiImage)
    }
}

extension UIImage {
    func toData(compressionQuality: CGFloat = 1.0) -> Data? {
        return self.jpegData(compressionQuality: compressionQuality)
    }
}

extension View {
    public func asUIImage() -> UIImage {
        let controller = UIHostingController(rootView: self)
        
        controller.view.backgroundColor = .clear
        
        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
        UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)
        
        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.sizeToFit()
        
        let image = controller.view.asUIImage()
        controller.view.removeFromSuperview()
        return image
    }
}

extension UIView {
    public func asUIImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

extension Image {
    func toData(compressionQuality: CGFloat = 1.0) -> Data? {
        return self.asUIImage().toData(compressionQuality: compressionQuality)
    }
}
