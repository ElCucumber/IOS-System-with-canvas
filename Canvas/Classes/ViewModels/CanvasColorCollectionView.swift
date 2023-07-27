
import UIKit

class CanvasColorCollectionView: UICollectionView, UICollectionViewDataSource {
    
    private let lists: [Canvas.Color] = Canvas.Color.lists
    
    var currentColor: Canvas.Color? {
        didSet {
            self.move()
        }
    }
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.afterInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.afterInit()
    }
    
    
    private func afterInit() {
        self.backgroundColor = UIColor.clear
        self.reloadData()
        self.dataSource = self
    }
    
    
    func move() {
        guard let color: Canvas.Color = self.currentColor else {
            return
        }
        for (i, list) in self.lists.enumerated() {
            if list == color {
                let indexPath: IndexPath = IndexPath(row: i, section: 0)
                self.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        }
    }
    
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lists.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CanvasColorCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CanvasColorCollectionViewCell", for: indexPath) as! CanvasColorCollectionViewCell
        let list: Canvas.Color = self.lists[indexPath.row]
        cell.setCell(color: list)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print(sourceIndexPath, destinationIndexPath)
    }
}
