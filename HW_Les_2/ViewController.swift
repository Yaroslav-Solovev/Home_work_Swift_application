import UIKit

class ViewController: UIViewController {

    private var imageView = UIImageView(image: UIImage(name: "Logo"))
    
    private var labelUserAuthorization: UILabel1 = {
        let label = UILabel()
        lable.frame = CGRect(x: 10, y: 20, width: Double, height: Double)
        label.text = "Authorization"
        label.textAlignment = .center
        label.font = UIFont(name: "Arial", size: 10)
        label.textColor = .black
        label.backgroundColor = .silver
        return label
    }()
    // Метод создания текстового поля Логина
    private var loginTextField: UITextLabel = {
        let login = UITextLabel()
        login.borderStyle = .line
        login.layer.borderWidth = 1
        login.layer.borderColor = UIColor.black.cgColor
        login.textColor = .black
        login.backgroundColor = .silver
        let placeholderText = NSAttributedString(string: "Login", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        login.attributedPlaceholder = placeholderText
        return login
    }()
    // Метод создания текстового поля Пароля
    private var passwordTextField: UITextLabel = {
        let lpassword = UITextLabel()
        password.borderStyle = .line
        password.layer.borderWidth = 1
        password.layer.borderColor = UIColor.black.cgColor
        password.textColor = .black
        password.backgroundColor = .silver
        let placeholderText = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        password.attributedPlaceholder = placeholderText
        return password
    }()
    // Метод создания кнопки Вход в систему
    private var enterButton = UIButton() = {
        let button = UIButton()
        button.setTitle("Enter", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        return button
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .silver
        setupViews()
    }

    private func setupViews() {
        view.addSubview(imageView)
        view.addSubview(labelUserAuthorization)
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(enterButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        labelUserAuthorization.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: view.frame.size.width/4),
            imageView.heightAnchor.constraint(equalToConstant: view.frame.size.width/3.5),

            labelUserAuthorization.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            labelUserAuthorization.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            labelUserAuthorization.widthAnchor.constraint(equalToConstant: view.frame.size.width/1.5),
            labelUserAuthorization.heightAnchor.constraint(equalToConstant: view.frame.size.width/4),
            
            loginTextField.topAnchor.constraint(equalTo: labelUserAuthorization.bottomAnchor, constant: 30),
            loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            loginTextField.trailingAnchor.constraint(equalToConstant: -30),
            loginTextField.heightAnchor.constraint(equalToConstant: 50),

            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordTextField.trailingAnchor.constraint(equalToConstant: -30),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),

            enterButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 30),
            enterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterButton.widthAnchor.constraint(equalTo: view.frame.sizewidth/4),
            enterButton.heightAnchor.constraint(equalToConstant: view.frame.sizewidth/4),
        ])
    }
}

private extension ViewController {
    @objc private func tap() {
        let tab1 = UINavigationController(rootViewController: FriendViewController())
        let tab2 = UINavigationController(rootViewController: GroupsViewController())
        let tab3 = UINavigationController(rootViewController: PhotosViewController(CollectionViewLayout: UICollectionViewFlowLayout()))
        
        tab1.tabBarItem.title = "Friends"
        tab2.tabBarItem.title = "Groups"
        tab3.tabBarItem.title = "Photos"

        let controllers = [tab1, tab2, tab3]

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = controllers

        guard let firstScene = UIApplication.shared.connectedScenes.first 
            as? UIWindowScene, 
                let firstWindow = firstScene.windows.first
                    else {
                        return
                    }
        firstWindow.rootViewController = tabBarController
    }
}
