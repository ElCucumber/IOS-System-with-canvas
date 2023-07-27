
import UIKit

class TextEditorViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var keyboardToasterView: KeyboardToasterView!
    
    @IBOutlet weak var keyboardToasterViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bodyTextView: CanvasBodyTextView!
    
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var fontSizeSlider: UISlider!
    
    @IBOutlet weak var textDecorationButton: TextDecorationButton!
    
    @IBOutlet weak var colorCollectionView: CanvasColorCollectionView!
    
    @IBOutlet weak var alignChangerButton: AlignChangerButton!
    
    
    var label: TextEditorLabel?
    
    var align: Canvas.Align = .center {
        didSet {
            alignChangerButton.align = self.align
            bodyTextView.align = self.align
        }
    }
    
    var color: Canvas.Color = .black {
        didSet {
            textDecorationButton.color = self.color
            alignChangerButton.color = self.color
            bodyTextView.color = self.color
            colorCollectionView.currentColor = self.color
            fontSizeSlider.tintColor = UIColor.rgb(rgbValue: self.color.rawValue, alpha: 1)
        }
    }
    
    var textDecoration: Canvas.TextDecoration = .none {
        didSet {
            textDecorationButton.style = self.textDecoration
            bodyTextView.textDecoration = self.textDecoration
        }
    }
    
    var didFinish: ((_ text: String, _ fontSize: CGFloat, _ color: Canvas.Color, _ align: Canvas.Align, _ textDecoration: Canvas.TextDecoration) -> Void)?
    
    var fontSize: CGFloat = 30 {
        didSet {
            bodyTextView.font = UIFont.systemFont(ofSize: self.fontSize, weight: .semibold)
            fontSizeSlider.value = Float(self.fontSize)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.rgb(rgbValue: 0x000000, alpha: 0.4)
        
//        let effect = UIBlurEffect(style: UIBlurEffectStyle.dark);
//        let effectView = UIVisualEffectView(effect: effect);
//        effectView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
//        blurView.addSubview(effectView);
//        blurView.layer.opacity = 0
        
        self.initTextView()
        self.initButton()
        self.initKeyboardView()
        
        colorCollectionView.delegate = self
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.prepareTextView()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.prepareObservers()
        bodyTextView.becomeFirstResponder()
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.removeObservers()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        colorCollectionView.move()
    }
    
    
    private func initTextView() {
        bodyTextView.text = ""
        fontSizeSlider.maximumValue = 70
        fontSizeSlider.minimumValue = 11
        fontSizeSlider.addTarget(self, action: #selector(self.changeFontSizeSlider(_:)), for: .valueChanged)
    }
    
    
    private func initButton() {
        textDecorationButton.addTarget(self, action: #selector(self.onTextDeorationButton(_:)), for: .touchDown)
        alignChangerButton.addTarget(self, action: #selector(self.onAlignChangerButton(_:)), for: .touchDown)
        doneButton.addTarget(self, action: #selector(self.onDoneButton(_:)), for: .touchDown)
    }
    
    
    private func initKeyboardView() {
        keyboardToasterView.relatedViewToTargetView = self.view
        keyboardToasterView.targetViewButtomConstraint = keyboardToasterViewBottomConstraint
    }
    
    
    private func prepareObservers() {
        keyboardToasterView.prepareObservers()
    }
    
    
    private func removeObservers() {
        keyboardToasterView.removeObservers()
    }
    
    
    private func prepareTextView() {
        guard let label: TextEditorLabel = self.label else {
            self.fontSize = 30
            self.align = .center
            self.color = .white
            self.textDecoration = .none
            return
        }
        self.fontSize = label.fontSize
        self.align = label.align
        self.color = label.color
        self.textDecoration = label.textDecoration
        bodyTextView.text = label.text
    }
    
    
    // MARK: - Target Slider
    
    @objc func changeFontSizeSlider(_ sender: UISlider) {
        self.fontSize = CGFloat(fontSizeSlider.value)
    }
    
    
    // MARK: - Target Button
    
    @objc func onAlignChangerButton(_ sender: UIButton) {
        alignChangerButton.change { (align: Canvas.Align) in
            self.align = align
        }
    }
    
    
    @objc func onTextDeorationButton(_ sender: UIButton) {
        switch self.textDecoration {
        case .clearBorder:
            self.textDecoration = .none
        case .none:
            self.textDecoration = .clearBorder
        }
    }
    
    
    @objc func onBlackButton(_ sender: UIButton) {
        self.color = .black
    }
    
    
    @objc func onRedButton(_ sender: UIButton) {
        self.color = .red
    }
    
    
    @objc func onDoneButton(_ sender: UIButton) {
        self.dismiss(animated: false) {
            if self.bodyTextView.text != "" {
                self.didFinish?(self.bodyTextView.text, self.fontSize, self.color, self.align, self.textDecoration)
            }
        }
    }
    
    
    // MARK: -- UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell: CanvasColorCollectionViewCell = collectionView.cellForItem(at: indexPath) as? CanvasColorCollectionViewCell else {
            return
        }
        self.color = cell.color
    }
    
}
