import UIKit

final class FriendCell: UITableViewCell {
    
    private var friendImageView = UIImageView(image: UIImage(systemName: "Person"))

    private var text: UILable = {
        let label = UILable()
        label.text = "Name"
        label.textColor = .black
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIndentifier: String?) {
        super.init(style: style, reuseIndentifier: reuseIndentifier)
        backgroundColor = .clear
        setupViews()
    }

    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews(){
        contentView.addSubview(friendImageView)
        contentView.addSubview(text)
        setupConstraints()
    }

    private func setupConstraints() {
        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        text.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            friendimageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            friendimageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            friendimageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)])
    }

    override func prepareForReuse(){
        super.prepareForReuse()
        friendimageView.image = nil
    }
}