
import UIKit

extension UIColor {
    
    class func rgb(rgbValue: UInt, alpha: Float) -> UIColor {
        return UIColor.rgbColor(rgbValue: rgbValue, alpha: alpha)
    }
    
    class private func rgbColor(rgbValue: UInt, alpha: Float) -> UIColor {
        return UIColor(
            red:   CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >>  8) / 255.0,
            blue:  CGFloat( rgbValue & 0x0000FF)        / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
}
