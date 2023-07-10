import UIKit

final class FriendCell: UITableViewCell {
    
    private var friendImageView = UIImageView(image: UIImage(systemName: "Person"))

    private var text: UILable = {
        let label = UILable()
        label.text = "Name"
        label.textColor = .black
        return label
    }()

    private var onlineCircle: UIView = {
        let circle = UIView()
        circle.backgroundColor = .gray
        circle.layer.cornerRadius = 12
        return circle
    }()

    override init(style: UITableViewCell.CellStyle, reuseIndentifier: String?) {
        super.init(style: style, reuseIndentifier: reuseIndentifier)
        backgroundColor = .clear
        setupViews()
    }

    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }

    func updateCell(model: Friend){
        text.text = (model.firstName ?? "") + " " + (model.lastName ?? "")
        if let online = model.online{
            let isOnline = online == 1
            if isOnline{
                onlineCircle.backgroundColor = .green
            } else {
                onlineCircle.backgroundColor = .red
            }
        }
        DispatchQueue.global().async{
            if let url = URL(string: model.photo ?? ""), let data = try?
                Data(contentsOf: url)
            {
                DispatchQueue.main.async{
                    self.friendImageView.image = UIImage(data: data)
                }
            }
        }
    }

    private func setupViews(){
        contentView.addSubview(friendImageView)
        contentView.addSubview(text)
        friendImageView.addSubview(onlineCircle)
        setupConstraints()
    }

    private func setupConstraints() {
        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        text.translatesAutoresizingMaskIntoConstraints = false
        onlineCircle.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            friendimageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            friendimageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            friendimageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)])
            friendimageView.widthAnchor.constraint(equalToConstant: 50)]
            friendimageView.heighAnchor.constraint(equalToConstant: friendimageView.widthAnchor)]
    }

    override func prepareForReuse(){
        super.prepareForReuse()
        friendimageView.image = nil
    }
}