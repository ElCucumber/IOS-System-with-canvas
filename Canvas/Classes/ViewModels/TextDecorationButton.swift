
import UIKit

class TextDecorationButton: UIButton {
    
    var color: Canvas.Color? {
        didSet {
            self.update()
        }
    }
    
    var style: Canvas.TextDecoration? {
        didSet {
            self.update()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.afterInit()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.afterInit()
    }
    
    
    private func afterInit() {
        self.tintColor = UIColor.clear
        self.backgroundColor = UIColor.clear
        self.layer.borderWidth = 2
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.clear.cgColor
    }
    
    
    private func update() {
        guard let style: Canvas.TextDecoration = self.style else {
            return
        }
        guard let color: Canvas.Color = self.color else {
            return
        }
        switch style {
        case .none:
            self.tintColor = UIColor.rgb(rgbValue: color.rawValue, alpha: 1)
            self.backgroundColor = UIColor.clear
            self.layer.borderColor = UIColor.rgb(rgbValue: color.rawValue, alpha: 1).cgColor
        case .clearBorder:
            self.tintColor = UIColor.white
            self.backgroundColor = UIColor.rgb(rgbValue: color.rawValue, alpha: 0.5)
            self.layer.borderColor = UIColor.rgb(rgbValue: color.rawValue, alpha: 0.5).cgColor
        }
    }
    
}
