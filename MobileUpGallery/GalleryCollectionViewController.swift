import UIKit
import Kingfisher

private let reuseIdentifier = "Cell"

class GalleryCollectionViewController: UICollectionViewController {

	private var items = [
		"https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074_1280.jpg",
		"https://cdn.pixabay.com/photo/2018/03/31/06/31/dog-3277416_1280.jpg",
		"https://cdn.pixabay.com/photo/2018/05/07/10/48/husky-3380548_1280.jpg",
		"https://cdn.pixabay.com/photo/2016/05/09/10/42/weimaraner-1381186_1280.jpg",
	]


    override func viewDidLoad() {
        super.viewDidLoad()
		self.collectionView.backgroundColor = .systemBackground
        // Register cell classes
		let nib = UINib(nibName: "GalleryCollectionViewCell", bundle: nil)
		self.collectionView.register(nib, forCellWithReuseIdentifier: "Cell")

        // Do any additional setup after loading the view.
    }

	static func generateLayout() -> UICollectionViewLayout{
		let spacing: CGFloat = 1
		let itemSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .fractionalHeight(1))
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		item.contentInsets = NSDirectionalEdgeInsets(
			top: 0,
			leading: spacing,
			bottom: 0,
			trailing: spacing
		)

		let groupSize = NSCollectionLayoutSize(
			widthDimension: .fractionalWidth(1),
			heightDimension: .fractionalWidth(0.5)
		)

		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)

		group.contentInsets = NSDirectionalEdgeInsets(
			top: spacing,
			leading: spacing,
			bottom: 0,
			trailing: spacing
		)

		let section = NSCollectionLayoutSection(group: group)

		section.interGroupSpacing = spacing

		let layout = UICollectionViewCompositionalLayout(section: section)

		return layout
	}


    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
		items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GalleryCollectionViewCell
    
        // Configure the cell
		let url = URL(string: items[indexPath.item])
		
		cell.backgroundColor = .systemTeal
		cell.clipsToBounds = true
		cell.imageView.kf.setImage(with: url)
		cell.imageView.contentMode = .scaleAspectFill
    
        return cell
    }

	// Sets custom back button for didSelectItemAt

	func setBackButtonSettings(){
		let backButton = UIBarButtonItem()
		backButton.title = ""
		backButton.image = UIImage(named: "Back_button")
		backButton.tintColor = .black
		navigationItem.backBarButtonItem = backButton
	}

    // MARK: UICollectionViewDelegate

	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print("Cell \(indexPath.row + 1) clicked")
		let viewController = ImageViewController()
		setBackButtonSettings()
		let cell = collectionView.cellForItem(at: indexPath) as! GalleryCollectionViewCell
		viewController.image = cell.imageView.image
		navigationController?.pushViewController(viewController, animated: true)
	}
}
