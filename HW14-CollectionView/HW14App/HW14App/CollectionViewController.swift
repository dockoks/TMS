import UIKit

final class CollectionViewController: UIViewController {
    
    private enum Constants {
        static let collectionViewPadding: CGFloat = 16
        static let itemLineSpacing: CGFloat = 12
        static let headerHeight: CGFloat = 48
        static let itemSpacing: CGFloat = 12
        static let itemsInRowNumber: Int = 3
    }
    
    private var data: [ProductSection] = []
    lazy var collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: .init())
    
    init() {
        super.init(nibName: nil, bundle: nil)
        let layout = UICollectionViewFlowLayout()
        layout.sectionHeadersPinToVisibleBounds = true
        
        let itemsInRow = CGFloat(Constants.itemsInRowNumber)
        let totalSpacing = (itemsInRow-1) * Constants.itemSpacing + 2 * Constants.collectionViewPadding
        let itemWidth = (UIScreen.main.bounds.width - totalSpacing) / itemsInRow
        let itemHeight = (UIScreen.main.bounds.width) / 2
        layout.minimumLineSpacing = Constants.itemLineSpacing
        layout.minimumInteritemSpacing = Constants.itemSpacing
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.headerReferenceSize = CGSize(width: collectionView.frame.width, height: Constants.headerHeight)
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        setupData()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        collectionView.contentInset = UIEdgeInsets(
            top: Constants.collectionViewPadding,
            left: Constants.collectionViewPadding,
            bottom: Constants.collectionViewPadding,
            right: Constants.collectionViewPadding
        )
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        collectionView.register(CollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionHeaderView.identifier)
    }
    
    private func setupData() {
        let iphoneSection = ProductSection(title: "iPhones", items: [
            ProductItem(
                icon: UIImage(systemName: "iphone.smartbatterycase.gen1")!,
                model: "iPhone 12",
                color: .systemBlue
            ),
            ProductItem(
                icon: UIImage(systemName: "iphone.smartbatterycase.gen2")!,
                model: "iPhone 13",
                color: .systemCyan
            ),
            ProductItem(
                icon: UIImage(systemName: "iphone.smartbatterycase.gen2")!,
                model: "iPhone 14",
                color: .systemMint
            ),
            ProductItem(
                icon: UIImage(systemName: "iphone.smartbatterycase.gen2")!,
                model: "iPhone 15",
                color: .systemTeal
            ),
        ])
        
        let ipadSection = ProductSection(title: "Ipads", items: [
            ProductItem(
                icon: UIImage(systemName: "ipad.gen1")!,
                model: "Ipad Air",
                color: .systemGreen
            ),
            ProductItem(
                icon: UIImage(systemName: "ipad.gen2")!,
                model: "Ipad Pro",
                color: .systemYellow
            )
        ])
        
        let macSection = ProductSection(title: "MacBooks", items: [
            ProductItem(
                icon: UIImage(systemName: "macbook.gen1")!,
                model: "MacBook Air",
                color: .systemOrange
            ),
            ProductItem(
                icon: UIImage(systemName: "macbook.gen2")!,
                model: "MacBook Pro",
                color: .systemRed
            )
        ])
        
        let visionSection = ProductSection(title: "Vision", items: [
            ProductItem(
                icon: UIImage(systemName: "visionpro")!,
                model: "Vision Pro",
                color: .systemPink
            ),
            ProductItem(
                icon: UIImage(systemName: "questionmark.app.dashed")!,
                model: "???",
                color: .systemIndigo
            )
        ])
        
        data = [iphoneSection, ipadSection, macSection, visionSection]
    }
}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
        let productItem = data[indexPath.section].items[indexPath.item]
        cell.configure(with: productItem)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionHeaderView.identifier, for: indexPath) as! CollectionHeaderView
        headerView.configure(with: data[indexPath.section].title)
        return headerView
    }
}
