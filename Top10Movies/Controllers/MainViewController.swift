import UIKit

class MainViewController: UIViewController{
    
    @IBOutlet weak var movieTable: UITableView!
    let loadingIndicator = LoadingIndicator()
    
    lazy var viewModel = {
          MovieViewModel()
      }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
    }
    
    func errorAlert(message: String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func initView() {
        
        loadingIndicator.center = self.view.center
        self.view.addSubview(loadingIndicator)
        
        movieTable.delegate = self
        movieTable.dataSource = self

        movieTable.separatorColor = .white
        movieTable.separatorStyle = .singleLine
        movieTable.tableFooterView = UIView()
        movieTable.allowsSelection = true
        
        movieTable.register(MovieCell.nib, forCellReuseIdentifier: MovieCell.identifier)
    }
    
    
    func initViewModel() {
        viewModel.getPopularMovies()
        
        viewModel.errorOccured = { (message: String) in
            self.loadingIndicator.isLoading = false
            self.errorAlert(message: message)
        }        
        viewModel.moviesLoaded = { [weak self] in
            DispatchQueue.main.async {
                self?.movieTable.reloadData()
            }
        }
        
        viewModel.movieDetailsLoaded = { [weak self] in
            self!.dismiss(animated: true)
            let viewController = self?.storyboard?.instantiateViewController(withIdentifier: "movieDetails") as! MovieDetailsViewController
            viewController.modalPresentationStyle = .pageSheet
            self!.loadingIndicator.isLoading = false
            viewController.movieDetails = self?.viewModel.movieDetails
            
            self?.navigationController?.present(viewController, animated: true, completion: nil)
        }
    }
}

extension MainViewController: UITableViewDelegate{
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return 10
     }
}
 
extension MainViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.movieCellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else { fatalError("xib not found") }
        cell.cellViewModel = viewModel.getCellViewModel(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
          let headerView = UIView()
          headerView.backgroundColor = UIColor.clear
          return headerView
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieId = viewModel.getCellViewModel(at: indexPath).id
        self.loadingIndicator.isLoading = true
        viewModel.getMovieDetails(movieId: movieId!)
    }
}
