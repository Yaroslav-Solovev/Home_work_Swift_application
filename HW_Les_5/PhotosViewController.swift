import UIKit

final class PhotosViewController: UITableViewController {
    private let networkService = NetworkService()
    private var models: [Photo] = []
    
    override func viewDidLoad(){
        super.viewDidLoad()
        title = "Photos"
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: Constants.Identifier.photoCellIdentifier)
        tableView.register(PhotoCell.self, forCellReuseIndentifier: "PhotoCell")
        networkService.getPhotos{ [weak self] photos in 
            self?.models = photos
            DispatchQueue.main.async{
                self?.tableView.reloadData()
            }}
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        models.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{GroupCell()}

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
            guard let cell = collectionView.dequeueReusableCell(withIndentifier: 
            Constants.Identifier.photoCellIndentifier, for: indexPath) as? PhotoCell else {
                return UICollectionViewCell()
            }
            let model = models[indexPath.row]
            cell.updateCell(model: model)
            return cell
        }
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let cellSize = width / 2 - 20
        return SGSize(width: cellSize, height: cellSize)
    }
}