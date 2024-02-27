import UIKit

class DetailViewController: UIViewController {

    // call model
    let model = ProductsModel()
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

    @IBAction func deleteAction(_ sender: Any) {
        let deleteID = productDetail.first?.id
        model.deleteModelData(productID: deleteID ?? 0) { isSucceeded, data, error in
            DispatchQueue.main.async {
                if isSucceeded {
                    self.alertUser(title: "Success", message: "Entry Delete Success!")
                    self.navigationController?.popViewController(animated: true)
                } else if let error = error {
                    self.alertUser(title: "Error While Getting Data", message: "An error occurred while fetching data from the API: \(error)")
                }
            }
        }
    }
    
    func alertUser(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .default)
        alert.addAction(okay)
        self.present(alert, animated: true)
    }
}
