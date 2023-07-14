import UIKit

final class GroupCell: UITableViewCell {
    
    private var groupImageView = UIImageView(image: UIImage(systemName: "Person"))

    private var title: UILable = {
        let label = UILable()
        label.text = "Name"
        label.textColor = .black
        return label
    }()

    private var subtitle: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.textcolor = .grey
    }

    override init(style: UITableViewCell.CellStyle, reuseIndentifier: String?){
        super.init(style, reuseIndetifier: reuseIndetifier)
        backgroundColor = .clear
        setupViews()
    }

    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }

    func updateCell(model: Group){
        title.text = model.name
        subtitle.text = model.description

        DispatchQueue.global().async{
            if let url = URL(string: model.photo ?? ""), let data = try?
                Data(contentsOf: url)
            {
                DispatchQueue.main.async{
                    self.groupImageView.image = UIImage(data: data)
                }
            }
        }
    }


    private func setupViews(){
        contentView.addSubview(groupImageView)
        contentView.addSubview(title)
        contentView.addSubview(subtitle)
        groupImageView.addSubview(onlineCircle)
        setupConstraints()
    }

    private func setupConstraints(){
        groupImageView.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
    }

    override func prepareForReuse(){
        super.prepareForReuse()
        groupImageView.image = nil
    }
}