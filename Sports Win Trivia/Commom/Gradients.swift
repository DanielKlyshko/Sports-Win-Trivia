import UIKit

extension CAGradientLayer {
    
    static func createDarkBlueGradient() -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.black.cgColor,
            UIColor.init(red: 0/255, green: 51/255, blue: 102/255, alpha: 1).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        return gradient
    }
    
    static func createLightBlueGradient() -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.colors = [
            UIColor.init(red: 0, green: 123/255, blue: 1, alpha: 1).cgColor,
            UIColor.init(red: 0, green: 99/255, blue: 206/255, alpha: 1).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)

        return gradient
    }
}

extension UIView {
    func applyLightBlueGradient() -> CAGradientLayer {
        let gradient = CAGradientLayer()
        
        gradient.frame = self.bounds
        gradient.colors = [
            UIColor.init(red: 0, green: 123/255, blue: 1, alpha: 1).cgColor,
            UIColor.init(red: 0, green: 99/255, blue: 206/255, alpha: 1).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
}
