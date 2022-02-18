//
//  ResultPage.swift
//  Top10Movies
//
//  Created by Simon Hellner on 2022-02-14.
//

import ObjectMapper

class ResultPage<T>: Mappable{
    
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
