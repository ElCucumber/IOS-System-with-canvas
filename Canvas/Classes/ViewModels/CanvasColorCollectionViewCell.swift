
import UIKit

class CanvasColorCollectionViewCell: UICollectionViewCell {
    
    var color: Canvas.Color!
    
    
    func setCell(color: Canvas.Color) {
        self.color = color
        self.backgroundColor = UIColor.rgb(rgbValue: self.color.rawValue, alpha: 1)
        self.borderRadius = self.frame.width / 2
    }
    
}
