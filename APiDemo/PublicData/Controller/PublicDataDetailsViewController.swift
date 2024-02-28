import UIKit

class PublicDataDetailsViewController: UIViewController {
    
    var singleData: EntryObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDataLabels()
    }
    
    func addDataLabels() {
        guard let singleData = singleData else {
            return
        }
        
        var labelYPosition: CGFloat = 100
        
        let mirror = Mirror(reflecting: singleData)
        
        for case let (label?, value) in mirror.children {
            if let stringValue = value as? String {
                let labelText = "\(label): \(stringValue)"
                let label = UILabel(frame: CGRect(x: 20, y: labelYPosition, width: 250, height: 30))
                label.text = labelText
                self.view.addSubview(label)
                labelYPosition += 40
            }
        }
    }
}
