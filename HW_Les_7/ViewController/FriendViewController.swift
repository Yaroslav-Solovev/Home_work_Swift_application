import UIKit

final class FriendViewController: UITableViewController {
    private var networkService: NetworkServiceProtocol
    private var models: [Friend] = []
    private var fileCache: FileCacheProtocol

    init(networkService: NetworkServiceProtocol = NetworkService(), fileCache: FileCacheProtocol = FileCache()){
        super.init(nibName: nil, bundle: nil)
        self.networkService = networkService
        self.fileCache = fileCache
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        models = fileCache.fetchFriends()
        tableView.reloadData()
        title = "Friends"
        view.backgroundColor = Theme.currentTheme.backgroundColor
        tableView.backgroundColor = Theme.currentTheme.backgroundColor
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person", style: .plain, target: self, action: #selector(tap)))
        tableView.register(FriendCell.self, forCellReuseIndentifier: "FriendCell")
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(update), for: .valueChanged)
        getFriends()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        models.count
    }

    // Метод создания нескольких секций
    //override func numberOfSections(in tableView: UITableView) -> Int {указать число}

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIndentifier: 
        "FriendCell", for: indexPath) as? FriendCell else {
            return UITableViewCell()
        }
        let model = models[indexPath.row]
        cell.updateCell(model: model)
        cell.tap = { [weak self] text, photo in
            self?.navigationController?
                .pushViewController(ProfileViewcontroller(name: text, 
                photo: photo, isUserProfile: false), animated: true)
        }
        return cell
    }

    func getFriends(){
        networkService.getFriends{ [weak self] result in switch result{
            case .success(let friends):
                self?.models = friends
                self?.fileCache.addFriends(friends: friends)
                DispatchQueue.main.async{
                    self?.tableView.reloadData()
                }
            case .failure(_):
                self?.models = self?.fileCache.fetchFriends() ?? []
                DispatchQueue.main.async{
                    self?.showAlert()
                    self?.tableView.reloadData()
                }
            }
        }
    }
    // метод создания анимационного перехода
    private extension FriendViewController{
        @objc func tap(){
            let animation = CATransition()
            animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
            animation.type = .moveIn
            animation.duration = 2
            navigationController?.view.layer.add(animation, forKey: nil)
            navigationController?.pushViewController(ProfileViewController(isUserProfile: true), animated: false)
        }

        @objc func update(){
            networkService.getFriends{ [weak self] result in switch result{
                case .success(let friends):
                    self?.models = friends
                    self?.fileCache.addFriends(friends: friends)
                    DispatchQueue.main.async{
                        self?.tableView.reloadData()
                }
                case .failure(_):
                    self?.models = self?.fileCache.fetchFriends() ?? []
                    DispatchQueue.main.async{
                        self?.showAlert()
                        self?.tableView.reloadData()
                }
                DispatchQueue.main.async{
                    self?.refreshControl?.endRefreshing()
                }     
            }
        }
    } 

    private extension FriendViewController{
        func showAlert(){
            let date = DateHelper.getDate(date: fileCache.fetchFriendDate())
            let alert = UIAlertController(title: "Failed to get data", 
            message: "Data is up to date \(date)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Exit", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}