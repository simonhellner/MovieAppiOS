import Foundation
import Alamofire
import ObjectMapper

protocol MovieServiceProtocol{
    func getMovies(completion: @escaping (Bool, Movies?, String?) -> ())
    func getMovieDetils(movieId: Int, completion: @escaping (Bool, Movie?, String?) -> ())
}

class MovieService: MovieServiceProtocol{
    
    func getMovies(completion: @escaping (Bool, Movies?, String?) -> ()) {
        var url = Constans.apiBaseUrl
        url.appendPathComponent("movie/popular")
        let urlParams = ["api_key": Constans.apiKey]
        
        AF.request(url, parameters: urlParams).validate().response{response in
            switch response.result{
                
                case .success:
                    let responseJson = String(data : response.value!!, encoding : String.Encoding.utf8)
                    let resultPage = Mapper<ResultPage<Movie>>().map(JSONString: responseJson!)!
                    let top10Movies = Array(resultPage.results[0...10])
                    completion(true, top10Movies, nil)
                
                 case let .failure(error):
                    completion(false, nil, error.errorDescription)
                
            }
        }
    }
    
    func getMovieDetils(movieId: Int, completion: @escaping (Bool, Movie?, String?) -> ()){
        var url = Constans.apiBaseUrl
        url.appendPathComponent("movie")
        url.appendPathComponent(String(movieId))
        let urlParams = ["api_key": Constans.apiKey]
        
        AF.request(url, parameters: urlParams).validate().response{response in
            switch response.result{
                
                case .success:
                    let responseJson = String(data : response.value!!, encoding : String.Encoding.utf8)
                    let movie = Mapper<Movie>().map(JSONString: responseJson!)
                    completion(true, movie, nil)
                
                 case let .failure(error):
                    completion(false, nil, error.errorDescription)
                
            }
        }
    }
}
