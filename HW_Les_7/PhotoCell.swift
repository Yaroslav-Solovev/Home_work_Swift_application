import UIKit

final class PhotoCell: UICollectionViewCell{
    private let photoView = UIImageView(image: UIImage(systemName: "Person"))

    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }

    func updateCell(model: Photo){
        DispatchQueue.global().async{
            if let url = URL(string: model.sizes.first?.url ?? ""), let data = try?
                Data(contentsOf: url)
            {
                DispatchQueue.main.async{
                    self.photoImageView.image = UIImage(data: data)
                }
            }
        }
    }

    private func setupViews(){
        addSubview(photoView)
        setupConstraints()
    }
    
    private func setupConstraints(){
        photoView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            photoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photoView.topAnchor.constraint(equalTo: view.topAnchor),
            photoView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }

    override func prepareForReuse(){
        super.prepareForReuse()
        photoView.image = nil
    }
}