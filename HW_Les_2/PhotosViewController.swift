import UIKit

final class PhotosViewController: UITableViewController {
    override func viewDidLoad(){
        super.viewDidLoad()
        title = "Photos"
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: Constants.Identifier.photoCellIdentifier)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{return 6}

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{GroupCell()}

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIndentifier: Constants.Identifier.photoCellIdentifier, for: indexPath) as! PhotoCell
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let cellSize = width / 2 - 20
        return SGSize(width: cellSize, height: cellSize)
    }
}