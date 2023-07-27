
import UIKit

class BlackButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.afterInit()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.afterInit()
    }
    
    
    private func afterInit() {
        self.tintColor = UIColor.rgb(rgbValue: Canvas.Color.black.rawValue, alpha: 1.0)
    }
    
}
