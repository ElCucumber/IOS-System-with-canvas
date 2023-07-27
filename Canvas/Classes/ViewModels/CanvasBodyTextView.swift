
import UIKit

class CanvasBodyTextView: UITextView {
    
    var align: Canvas.Align? {
        didSet {
            guard let align: Canvas.Align = self.align else {
                return
            }
            switch align {
            case .left:
                self.textAlignment = .left
            case .center:
                self.textAlignment = .center
            case .right:
                self.textAlignment = .right
            }
        }
    }
    
    var color: Canvas.Color? {
        didSet {
            self.updateColor()
        }
    }
    
    
    var textDecoration: Canvas.TextDecoration? {
        didSet {
            self.updateColor()
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.afterInit()
    }
    
    
    private func afterInit() {
        self.tintColor = UIColor.white
        self.textColor = UIColor.clear
        self.backgroundColor = UIColor.clear
    }
    
    
    private func updateColor() {
        guard let color: Canvas.Color = self.color else {
            return
        }
        guard let textDecoration: Canvas.TextDecoration = self.textDecoration else {
            return
        }
        switch textDecoration {
        case .none:
            self.textColor = UIColor.rgb(rgbValue: color.rawValue, alpha: 1.0)
            self.backgroundColor = UIColor.clear
        case .clearBorder:
            self.textColor = UIColor.white
            self.backgroundColor = UIColor.rgb(rgbValue: color.rawValue, alpha: 0.5)
        }
    }
}
