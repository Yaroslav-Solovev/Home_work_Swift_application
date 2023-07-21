struct User: Decodable{
    var response: [User]
}

struct User: Decodable{
    var firstName: String?
    var lastName: String?
    var photo: String?

    enum CodingKeys: String, codingKey{
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_250_orig"
    }
}