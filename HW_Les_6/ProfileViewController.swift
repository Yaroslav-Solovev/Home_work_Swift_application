import UIKit

final class ProfileViewController: UIViewController {
    private var networkService = NetworkService()
    private var profileImageView = UIImageView
    private var nameLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    } ()

    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        networkService.getProfileInfo{ 
            [weak self] user in self?.updateData(model: user)
        }
    }

    func updateData(model: User?){
        guard let model = model else {return}
        DispatchQueue.global().async{
            if let url = URL(string: model.photo ?? ""), let data = try? Data(contentsOf: url){
                DispatchQueue.main.async{
                    self.profileImageView.image = UIImage(data: data)
                }
            }
        }
    }

    private func setupViews(){
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        setupConstraints()
    }

    private func setupConstraints(){
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            profileImageView.centerYAnchor.contraint(equalTo: view.centerYAnchor, constant: -50)
            profileImageView.leadingAnchor.contraint(equalTo: view.leadingAnchor, constant: 30)
            profileImageView.trailingAnchor.contraint(equalTo: view.trailingAnchor, constant: -30)
            profileImageView.heightAnchor.contraint(equalTo: profileImageView.widthAnchor)

            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
            nameLabel.trailingAnchor.contraint(equalTo: view.trailingAnchor, constant: -30)
            nameLabel.topAnchor.contraint(equalTo: profileImageView..bottomAnchor, constant: 30)
        ])
    }
}
