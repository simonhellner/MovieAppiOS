import ObjectMapper
typealias Movies = [Movie]

class Movie : Mappable{
    
    var id: Int!
    var name: String!
    var backdropUrl: String!
    
    // These are optional since they're only
    // used for movie details
    var overview: String?
    var voteAverage: Double?
    var runtime: Int?
    var genres: Array<Genre>?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["title"]
        backdropUrl <- map["backdrop_path"]
        
        overview <- map["overview"]
        voteAverage <- map["vote_average"]
        runtime <- map["runtime"]
        genres <- map["genres"]
    }
}
