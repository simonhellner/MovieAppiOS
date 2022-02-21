import UIKit

// This is not a Controller so it probably
// shouldn't be in the Controller folder
class LoadingIndicator: UIView {
    var indicatorSpinner = UIActivityIndicatorView()
    
    public var isLoading: Bool {
        get{
            return indicatorSpinner.isAnimating
        }
        set(value){
            if(value){
                indicatorSpinner.startAnimating()
                isHidden = false
            }
            else{
                indicatorSpinner.stopAnimating()
                isHidden = true
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initView() {
        backgroundColor = UIColor(white: 0, alpha: 0.7)

        indicatorSpinner.style = UIActivityIndicatorView.Style.large
        indicatorSpinner.color = UIColor.white
        indicatorSpinner.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(indicatorSpinner)
        indicatorSpinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        indicatorSpinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        layer.cornerRadius = 10
        
        isHidden = true
    }
}

