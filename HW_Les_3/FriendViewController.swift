import UIKit

final class FriendViewController: UITableViewController {
    private let NetworkService = NetworkService()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        title = "Friend"
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.tintColor = .black
        networkService.getFriends()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{5}

    // Метод создания нескольких секций
    //override func numberOfSections(in tableView: UITableView) -> Int {указать число}

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{FriendCell()}

}