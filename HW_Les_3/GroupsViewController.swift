import UIKit

final class GroupsViewController: UITableViewController {
    private let NetworkService = NetworkService()

    override func viewDidLoad(){
        super.viewDidLoad()
        title = "Groups"
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.tintColor = .white
        networkService.getGroups()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{5}

    // Метод создания нескольких секций
    //override func numberOfSections(in tableView: UITableView) -> Int {указать число}

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{GroupCell()}
}