import UIKit

final class FriendViewController: UITableViewController {
    override func viewDidLoad(){
        super.viewDidLoad()
        title = "Friend"
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.tintColor = .black
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{5}

    // Метод создания нескольких секций
    //override func numberOfSections(in tableView: UITableView) -> Int {указать число}

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{FriendCell()}

}