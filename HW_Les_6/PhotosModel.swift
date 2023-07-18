struct PhotosModel: Decodable{
    var response: Groups
}

struct Photos: Decodable{
    var items: [Photo]
}

struct Photo: Decodable{
    var id: Int
    var text: String?
    var sizes: [Sizes]   
}

struct Sizes: Codable{
    var url: String
}