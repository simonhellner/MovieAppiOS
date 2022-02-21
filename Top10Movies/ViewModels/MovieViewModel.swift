import Foundation

class MovieViewModel: NSObject{
    
    var movieService: MovieServiceProtocol
    
    var errorOccured: ((_ message: String) -> Void)?
    var moviesLoaded: (() -> Void)?
    var movieDetailsLoaded: (() -> Void)?
    
    var movieCellModels = [Movie]() {
        didSet {
            moviesLoaded!()
         }
     }
    
    var movieDetails:Movie? {
        didSet {
            movieDetailsLoaded!()
         }
     }
    
    init(movieService: MovieServiceProtocol = MovieService()){
        self.movieService = movieService
        super.init()
    }
    
    func getPopularMovies(){
        movieService.getMovies{ success, model, error in
            if success, let movies = model {
                var cellViewModels = [Movie]()
                for movie in movies{
                    cellViewModels.append(movie)
                }
                self.movieCellModels = cellViewModels
            }
            else {
                if(self.errorOccured != nil){
                    self.errorOccured!(error ?? "An unknown error has occurred")
                }
            }
        }
    }
    
    func getMovieDetails(movieId: Int){
        movieService.getMovieDetils(movieId: movieId, completion: { success, model, error in
            if success, let movie = model {
                self.movieDetails = movie
            }
            else{
                if(self.errorOccured != nil){
                    self.errorOccured!(error ?? "An unknown error has occurred")
                }
            }
        })
    }
    
    
    private func createCellModel(movie: Movie) -> Movie {
        return movie
    }

    func getCellViewModel(at indexPath: IndexPath) -> Movie {
        return movieCellModels[indexPath.section]
    }
}
