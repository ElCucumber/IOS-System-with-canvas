
import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var textBoardView: TextBoardView!
    
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var deleteViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nextButtonBottomConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.iniMenu()
        self.initTextBoardView()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.layoutIfNeeded()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    private func iniMenu() {
        nextButtonBottomConstraint.constant = 12
        deleteViewBottomConstraint.constant = deleteView.frame.height * -1
        nextButton.addTarget(self, action: #selector(self.onNextButton(_:)), for: .touchDown)
    }
    
    
    private func initTextBoardView() {
        textBoardView.touchStart = {
            print("start")
            self.animateMenu(constraint: self.nextButtonBottomConstraint, constant: self.nextButton.frame.height * -1)
            self.animateMenu(constraint: self.deleteViewBottomConstraint, constant: 12)
        }
        textBoardView.touchFinish = { (index: Int, location: CGPoint) in
            if self.needRemove(location: location) {
                print("remove")
                self.textBoardView.remove(index: index)
            }
            print("finish")
            self.animateMenu(constraint: self.nextButtonBottomConstraint, constant: 12)
            self.animateMenu(constraint: self.deleteViewBottomConstraint, constant: self.deleteView.frame.height * -1)
        }
        textBoardView.didSelect = { (label: TextEditorLabel?) in
            self.gotoTextEditor(label: label)
        }
    }
    
    
    private func animateMenu(constraint: NSLayoutConstraint, constant: CGFloat) {
        let animate: UIViewPropertyAnimator = UIViewPropertyAnimator(duration: 0.1, curve: .easeIn) {
            constraint.constant = constant
            self.view.layoutIfNeeded()
        }
        animate.startAnimation()
    }
    
    
    private func needRemove(location: CGPoint) -> Bool {
        let minX: CGFloat = deleteView.frame.origin.x
        let maxX: CGFloat = deleteView.frame.origin.x + deleteView.frame.width
        let minY: CGFloat = deleteView.frame.origin.y - 40
        let maxY: CGFloat = deleteView.frame.origin.y + deleteView.frame.height
//        print(location.x, location.y)
//        print(minX, maxX, minY, maxY)
        if minX <= location.x && location.x <= maxX {
            if minY <= location.y && location.y <= maxY {
                return true
            }
        }
        return false
    }
    
    
    private func gotoTextEditor(label: TextEditorLabel?) {
        let storyboard: UIStoryboard = UIStoryboard(name: "TextEditor", bundle: nil)
        let vc: TextEditorViewController = storyboard.instantiateInitialViewController() as! TextEditorViewController
        vc.label = label
        vc.didFinish = { (text: String, fontSize: CGFloat, color: Canvas.Color, align: Canvas.Align, textDecoration: Canvas.TextDecoration) in
            if label == nil {
                if text != "" {
                    self.textBoardView.append(text: text, fontSize: fontSize, color: color, align: align, textDecoration: textDecoration)
                }
                return
            }
            if let l: TextEditorLabel = label {
                self.textBoardView.update(index: l.index, text: text, fontSize: fontSize, color: color, align: align, textDecoration: textDecoration)
            }
        }
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false, completion: nil)
    }
    
    
    private func gotoPreview() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Preview", bundle: nil)
        let vc: PreviewViewController = storyboard.instantiateInitialViewController() as! PreviewViewController
        vc.image = textBoardView.toImage()
        self.present(vc, animated: true, completion: nil)
    }
    
    
    // MARK: - Target Button
    
    @objc func onNextButton(_ sender: UIButton) {
        self.gotoPreview()
    }
    
}
