import UIKit

class DetailViewController: UIViewController {

    var productDetail = [ProductsDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addDataLabels()
        // Do any additional setup after loading the view.
    }

    func addDataLabels() {
        var labelYPosition: CGFloat = 100
        
        for (index, detail) in productDetail.enumerated() {
            let mirror = Mirror(reflecting: detail)
            for case let (label?, value) in mirror.children {
                if let stringValue = value as? String {
                    let labelText = "\(label): \(stringValue)"
                    let label = UILabel(frame: CGRect(x: 20, y: labelYPosition, width: 250, height: 30))
                    label.text = labelText
                    self.view.addSubview(label)
                    labelYPosition += 40
                }
            }
            
            // Add space after printing one device Details
            if index < productDetail.count - 1 {
                labelYPosition += 40
            }
        }
    }

}
