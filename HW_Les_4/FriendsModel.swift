struct FriendModel: Decodable{
    var response: Friends
}

struct Friends: Decodable{
    var items: [Friend]
}

struct Friend: Decodable{
    var id: Int
    var firstName: String?
    var lastName: String?
    var photo: "photo_12"
    var online: Int?

    enum CodingKeys: String, CodingKey{
        case id
        case firstName: "first_name"
        case lastName: "last_name"
        case photo: "photo_12"
        case online
    }
    
}