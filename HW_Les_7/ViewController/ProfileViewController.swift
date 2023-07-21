import UIKit

final class ProfileViewController: UIViewController {
    private var networkService: NetworkServiceProtocol
    private var profileImageView = UIImageView
    private var nameLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    } ()

    init(networkService: NetworkServiceProtocol = NetworkService()){
        super.init(nibName: nil, bundle: nil)
        self.networkService = networkService
    }

    private var themeView = Theme View()
    private var isUserProfile: Bool

    init(name: String? = nil, photo: UIImage? = nil, isUserProfile: Bool){
        self.isUserProfile = isUserProfile
        super.init(nibName: nil, bundle: nil)
        nameLabel.text = name
        profileImageView.image = photothemeView.delegate = self
    }

    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = Theme.currentTheme.backgroundColor
        setupViews()
        if isUserProfile{
            networkService.getProfileInfo{ 
                [weak self] user in self?.updateData(model: user)
            }
        } else {
            themeView.isHidden = true
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
        view.addSubview(themeView)
        setupConstraints()
    }

    private func setupConstraints(){
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        themeView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            profileImageView.centerYAnchor.contraint(equalTo: view.centerYAnchor, constant: -50)
            profileImageView.leadingAnchor.contraint(equalTo: view.leadingAnchor, constant: 30)
            profileImageView.trailingAnchor.contraint(equalTo: view.trailingAnchor, constant: -30)
            profileImageView.heightAnchor.contraint(equalTo: profileImageView.widthAnchor)

            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
            nameLabel.trailingAnchor.contraint(equalTo: view.trailingAnchor, constant: -30)
            nameLabel.topAnchor.contraint(equalTo: profileImageView.bottomAnchor, constant: 30)

            themeView.leadingAnchor.contraint(equalTo: view.leadingAnchor)
            themeView.trailingAnchor.contraint(equalTo: view.trailingAnchor)
            themeView.topAnchor.contraint(equalTo: nameLabel.bottomAnchor, constant: 30)
            themeView.bottomAnchor.contraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}

extension ProfileViewController: ThemeViewDelegate{
    func updateColor(){
        view.backgroundColor = Theme.currentTheme.backgroundColor
        nameLabel.textColor = Theme.currentTheme.textColor
    }
}