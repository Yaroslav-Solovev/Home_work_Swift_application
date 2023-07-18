import UIKit

final class GroupsViewController: UITableViewController {
    private let networkService = NetworkService()
    private var models: [Group] = []
    private var fileCache = FileCache()

    override func viewDidLoad(){
        super.viewDidLoad()
        models = fileCache.fetchGroups()
        tableView.reloadData()
        title = "Groups"
        view.backgroundColor = Theme.currentTheme.backgroundColor
        tableView.backgroundColor = Theme.currentTheme.backgroundColor
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.tintColor = .white
        tableView.register(GroupCell.self, forCellReuseIndentifier: "GroupCell")
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(update), for: .valueChanged)
        getGroupss()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        models.count
    }

    // Метод создания нескольких секций
    //override func numberOfSections(in tableView: UITableView) -> Int {указать число}

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIndentifier: 
        "GroupCell", for: indexPath) as? GroupCell else {
            return UITableViewCell()
        }
        let model = models[indexPath.row]
        cell.updateCell(model: model)
        return cell
    }

    func getGroups(){
        networkService.getGroups{ [weak self] result in switch result{
            case .success(let groups):
                self?.models = groups
                self?.fileCache.addGroups(groups: groups)
                DispatchQueue.main.async{
                    self?.tableView.reloadData()
                }
            case .failure(_):
                self?.models = self?.fileCache.fetchGroups() ?? []
                DispatchQueue.main.async{
                    self?.showAlert()
                }
            }
        }

        @objc func update(){
            networkService.getGroups{ [weak self] result in switch result{
                case .success(let groups):
                    self?.models = groups
                    self?.fileCache.addGroups(groups: groups)
                    DispatchQueue.main.async{
                        self?.tableView.reloadData()
                }
                case .failure(_):
                    self?.models = self?.fileCache.fetchGroups() ?? []
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

    private extension GroupViewController{
        func showAlert(){
            let date = DateHelper.getDate(date: fileCache.fetchFriendDate())
            let alert = UIAlertController(title: "Failed to get data", 
            message: "Data is up to date \(date)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Exit", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}