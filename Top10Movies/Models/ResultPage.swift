import ObjectMapper

class ResultPage: Mappable{
    
    var page: Int!
    var results: Array<Movie>!
    var total_pages: Int!
    var total_results: Int!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        page <- map["page"]
        results <- map["results"]
        total_pages <- map["total_pages"]
        total_results <- map["total_results"]
    }
}
