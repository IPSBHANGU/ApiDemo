import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    // call model
    let model = ProductsModel()
    var productDetail = [ProductsDetail]()
    var keyNamesArray: [String] = [
        "title",
        "description",
        "brand",
        "category"
    ]
    var key: String?
    
    var keyPicker = UIPickerView()
    var keyValueText = UITextField()
    var submitButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addDataLabels()
        setupPickerView()
        setupTextField()
        setupSubmitButton()
    }

    func setupPickerView() {
        keyPicker.alpha = 0
        keyPicker.frame = CGRect(x: 0, y: 577, width: 393, height: 216)
        keyPicker.delegate = self
        keyPicker.dataSource = self
        view.addSubview(keyPicker)
    }
    
    func setupTextField(){
        keyValueText.alpha = 0
        keyValueText.frame = CGRect(x: 24, y: 520, width: 340, height: 45)
        keyValueText.tintColor = .black
        keyValueText.layer.cornerRadius = 9.0
        keyValueText.layer.borderColor = UIColor.black.cgColor
        keyValueText.layer.borderWidth = 2.0
        keyValueText.placeholder = "Enter Here"
        view.addSubview(keyValueText)
    }
    
    func setupSubmitButton() {
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.alpha = 0
        submitButton.frame = CGRect(x: 100, y: 580, width: 200, height: 35)
        submitButton.addTarget(self, action: #selector(hitApi), for: .touchDown)
        submitButton.layer.cornerRadius = 9.0
        submitButton.layer.borderColor = UIColor.black.cgColor
        submitButton.layer.borderWidth = 2.0
        view.addSubview(submitButton)
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

    func removeDataLabels() {
        for subview in self.view.subviews {
            if let label = subview as? UILabel {
                UIView.animate(withDuration: 0.5, animations: {
                    label.removeFromSuperview()
                })
            }
        }
    }
    
    func setupUpdateView(){
        removeDataLabels()
        UIView.animate(withDuration: 0.5, animations: {
            self.keyPicker.alpha = 1
            self.keyValueText.alpha = 1
            self.updateButton.alpha = 0
            self.deleteButton.alpha = 0
            self.submitButton.alpha = 1
        })
    }
    
    @objc func hitApi(){
        guard let productID = productDetail.first?.id else {return}
        guard let keyValue = keyValueText.text else { return }
        
        // call api
        model.updatePostModelData(productID: productID, key: key ?? "", keyValue: keyValue) { isSucceeded, data, error in
            DispatchQueue.main.async {
                if isSucceeded {
                    guard let data = data else {return}
                    self.productDetail.removeAll()
                    self.productDetail.append(data)
                    self.addDataLabels()
                } else if let error = error {
                    AlerUser.alertUser(viewController: self, title: "Error While Getting Data", message: "An error occurred while fetching data from the API: \(error)")
                }
            }
        }
    }
    
    @IBAction func updateAction(_ sender: Any) {
        setupUpdateView()
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        let deleteID = productDetail.first?.id
        model.deleteModelData(productID: deleteID ?? 0) { isSucceeded, data, error in
            DispatchQueue.main.async {
                if isSucceeded {
                    AlerUser.alertUser(viewController: self, title: "Success", message: "Entry Delete Success!")
                    self.navigationController?.popViewController(animated: true)
                } else if let error = error {
                    AlerUser.alertUser(viewController: self, title: "Error While Getting Data", message: "An error occurred while fetching data from the API: \(error)")
                }
            }
        }
    }
}

extension DetailViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return keyNamesArray.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return keyNamesArray[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        key = keyNamesArray[row]
    }
}

