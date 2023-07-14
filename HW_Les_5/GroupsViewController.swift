import UIKit

final class GroupsViewController: UITableViewController {
    private let networkService = NetworkService()
    private var models: [Group] = []

    override func viewDidLoad(){
        super.viewDidLoad()
        title = "Groups"
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.tintColor = .white
        tableView.register(GroupCell.self, forCellReuseIndentifier: "GroupCell")
        networkService.getGroups{ [weak self] groups in 
            self?.models = groups
            DispatchQueue.main.async{
                self?.tableView.reloadData()
            }}
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
}