//
//  Movie.swift
//  Top10Movies
//
//  Created by Simon Hellner on 2022-02-11.
//

import ObjectMapper
typealias Movies = [Movie]

class Movie : Mappable{
    
    var id: Int!
    var name: String!
    var backdropUrl: String!
    
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
