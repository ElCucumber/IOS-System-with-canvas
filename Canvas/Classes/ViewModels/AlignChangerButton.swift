
import UIKit

class AlignChangerButton: UIButton {
    
    var align: Canvas.Align = .center {
        didSet {
            self.setTitle()
        }
    }
    
    
    var color: Canvas.Color? {
        didSet {
            guard let color: Canvas.Color = self.color else {
                return
            }
            self.tintColor = UIColor.rgb(rgbValue: color.rawValue, alpha: 1)
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
        self.setTitle("", for: .normal)
    }
    
    
    func change(callback: (_ align: Canvas.Align) -> Void) {
        switch self.align {
        case .left:
            self.align = .right
        case .center:
            self.align = .left
        case .right:
            self.align = .center
        }
        callback(self.align)
    }
    
    
    private func setTitle() {
        var str: String = ""
        switch self.align {
        case .left:
            str = "左"
        case .center:
            str = "中"
        case .right:
            str = "右"
        }
        self.setTitle(str, for: .normal)
    }
    
}
