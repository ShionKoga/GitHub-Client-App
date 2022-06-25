import UIKit

extension UIImage {
    convenience init?(color: UIColor, size: CGSize) {
        guard let cgImage = UIGraphicsImageRenderer(size: size).image(actions: { rendererContext in
            rendererContext.cgContext.setFillColor(color.cgColor)
            rendererContext.fill(.init(origin: .zero, size: size))
        }).cgImage else {
            return nil
        }
        self.init(cgImage: cgImage)
    }
}
