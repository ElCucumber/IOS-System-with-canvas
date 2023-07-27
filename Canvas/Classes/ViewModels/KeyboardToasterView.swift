
import UIKit

class KeyboardToasterView: UIView {
    
    var relatedViewToTargetView: UIView?
    var targetViewButtomConstraint: NSLayoutConstraint?
    
    
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
    }
    
    
    func prepareObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.willShow(_:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.willHide(_:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    @objc func willShow(_ sender: Notification) {
        
        if self.targetViewButtomConstraint == nil {
            return
        }
        
        if let userInfo = sender.userInfo {
            
            let keyboardFrame: CGRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let animationDuration: Double = ((userInfo[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue)!
            
            self.refresh()
            self.resize(keyboardHeight: keyboardFrame.size.height, duration: animationDuration)
        }
    }
    
    
    @objc func willHide(_ sender: Notification) {
        self.refresh()
    }
    
    
    private func resize(keyboardHeight: CGFloat, duration: TimeInterval) {
        guard let view: UIView = self.relatedViewToTargetView else {
            return
        }
        guard let bottom: NSLayoutConstraint = self.targetViewButtomConstraint else {
            return
        }
        
        bottom.constant = keyboardHeight
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
            view.layoutIfNeeded()
        }, completion: nil)
    }
    
    
    private func refresh() {
        if let bottom: NSLayoutConstraint = targetViewButtomConstraint {
            bottom.constant = 0
        }
    }
}
