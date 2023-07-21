import Foundation

protocol NetworkServiceProtocol{
    static var token = ""
    static var userID = ""
    func getFriends(completion: @escaping(Result<[Friend], Error) -> Void)
    func getGroups(completion: @escaping([Group]) -> Void)
    func getPhotos(completion: @escaping([Photo]) -> Void)
    func getProfileInfo(completion: @escaping([User?]) -> Void)
}

final class NetworkService: NetworkServiceProtocol{
    private let session = URLSession.shared

    static var token = ""
    static var userID = ""

    func getFriends(completion: @escaping(Result<[Friend], Error) -> Void){ // вызов массив друзей
        guard let url = URL(string: 
            "https://api.vk.com/method/friends
            .get?fields=photo_12,online&access_token=\(NetworkService
            .token)&v=5.131") else {
                return
            }
        
        session.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                completion(.failure(NetworkError.dataError))
                return
            }
            if let error = error{
                completion(.failure(error))
                return
            }
            do {
                let friends = try
                    JSONDecoder().decode(FriendsModel.self, from: data)
                    completion(friends.response.items) // вызываем замыкание
                    print(friends)
            } catch {
                print(error)
            }
        }.resume()
    }

    func getGroups(completion: @escaping([Group]) -> Void){
        guard let url = URL(string: 
            "https://api.vk.com/method/groups
            .get?access_token=\(NetworkService
            .token)&fields=description&v=5.131&extended=1") else {
                return
            }
        
        session.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                return
            }
            do {
                let groups = try
                    JSONDecoder().decode(GroupsModel.self, from: data)
                    completion(groups.response.items)
                    print(groups)
            } catch {
                print(error)
            }
        }.resume()
    }

    func getPhotos(completion: @escaping([Photo]) -> Void){
        guard let url = URL(string: 
            "https://api.vk.com/method/photos
            .get?fields=bdate&access_token=\(NetworkService
            .token)&v=5.131&album_id=profile") else {
                return
            }
        
        session.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                return
            }
            do {
                let photos = try
                    JSONDecoder().decode(PhotosModel.self, from: data)
                    completion(photos.response.items)
                    print(photos)
            } catch {
                print(error)
            }
        }.resume()
    }

    func getProfileInfo(completion: @escaping([User?]) -> Void){
        guard let url = URL(string: 
            "https://api.vk.com/method/users
            .get?fields=photo_250_orig&access_token=\(NetworkService
            .token)&v=5.131") else {
                return
            }
    
        session.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                return
            }
            do {
                let user = try
                    JSONDecoder().decode(UserModel.self, from: data)
                    completion(user.response.first)
            } catch {
                print(error)
            }
        }.resume()
    }
}