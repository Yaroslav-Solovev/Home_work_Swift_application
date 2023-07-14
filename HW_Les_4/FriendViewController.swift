import UIKit

final class FriendViewController: UITableViewController {
    private let networkService = NetworkService()
    private var models: [Friend] = []
    
    override func viewDidLoad(){
        super.viewDidLoad()
        title = "Friends"
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.tintColor = .black
        tableView.register(FriendCell.self, forCellReuseIndentifier: "FriendCell")
        networkService.getFriends{ [weak self] friends in 
            self?.models = friends
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
        "FriendCell", for: indexPath) as? FriendCell else {
            return UITableViewCell()
        }
        let model = models[indexPath.row]
        cell.updateCell(model: model)
        return cell
    }

}