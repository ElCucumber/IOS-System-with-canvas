
import UIKit

class TextBoardView: UIView {
    
    private var texts: [TextEditorLabel] = [TextEditorLabel]()
    
    private var indexCounter: Int = 0
    
    private var selectedLabel: TextEditorLabel?
    
    var touchStart: (() -> Void)?
    
    var touchFinish: ((_ index: Int, _ location: CGPoint) -> Void)?
    
    var didSelect: ((_ label: TextEditorLabel?) -> Void)?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.afterInit()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.afterInit()
    }
    
    
    private func afterInit() {
        self.backgroundColor = UIColor.clear
        self.isUserInteractionEnabled = true
        self.isMultipleTouchEnabled = true
    }
    
    
    func append(text: String, fontSize: CGFloat, color: Canvas.Color, align: Canvas.Align, textDecoration: Canvas.TextDecoration) {
        let label: TextEditorLabel = TextEditorLabel(
            index: self.indexCounter,
            parentView: self,
            text: text,
            fontSize: fontSize,
            color: color,
            align: align,
            textDecoration: textDecoration
        )
        label.touchStart = { (label: TextEditorLabel) in
            self.selectedLabel = label
            self.touchStart?()
        }
        label.touchFinish = { (index: Int, location: CGPoint) in
            self.selectedLabel = nil
            self.touchFinish?(index, location)
        }
        label.didSelect = { (label: TextEditorLabel) in
            self.didSelect?(label)
        }
        self.texts.append(label)
        self.indexCounter += 1
    }
    
    
    func update(index: Int, text: String, fontSize: CGFloat, color: Canvas.Color, align: Canvas.Align, textDecoration: Canvas.TextDecoration) {
        for label in self.texts {
            if label.index == index {
                label.update(text: text, fontSize: fontSize, color: color, align: align, textDecoration: textDecoration)
                return
            }
        }
    }
    
    
    func remove(index: Int) {
        var removeIndex: Int?
        var removeLabel: TextEditorLabel?
        for (i, label) in self.texts.enumerated() {
            if label.index == index {
                removeIndex = i
                removeLabel = label
                break
            }
        }
        if let i: Int = removeIndex, let label: TextEditorLabel = removeLabel {
            self.texts.remove(at: i)
            label.removeFromSuperview()
        }
    }
    
    
    // MARK: - Touch Event
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label: TextEditorLabel = self.selectedLabel {
            label.handleTouchesBegan(touches: touches)
            return
        }
        self.didSelect?(nil)
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label: TextEditorLabel = self.selectedLabel {
            label.handleTouchesMoved(touches: touches)
            return
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label: TextEditorLabel = self.selectedLabel {
            if !label.isMoving {
                self.didSelect?(label)
            }
            label.handleTouchesEnded(touches: touches)
        }
    }
    
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label: TextEditorLabel = self.selectedLabel {
            label.handleTouchesCancelled(touches: touches)
            return
        }
    }
    
}
