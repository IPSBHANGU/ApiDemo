//
//  AddToAPIViewController.swift
//  APiDemo
//
//  Created by Inderpreet Singh on 27/02/24.
//

import UIKit

class AddToAPIViewController: UIViewController {

    
    @IBOutlet weak var keyPicker: UIPickerView!
    @IBOutlet weak var keyValueText: UITextField!
    
    // Call model
    let model = ProductsModel()
    var productDetail: ProductsDetail?
    var keyNamesArray: [String] = [
        "title",
        "description",
        "brand",
        "category"
    ]
    var key: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickerView()
    }

    func setupPickerView() {
        keyPicker.delegate = self
        keyPicker.dataSource = self
    }

    @IBAction func submitAction(_ sender: Any) {
        guard let keyValue = keyValueText.text else { return }
        model.addPostModelData(key: key ?? "", keyValue: keyValue) { [weak self] isSucceeded, data, error in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if isSucceeded {
                    self.productDetail = data
                    self.addDataLabels()
                } else if let error = error {
                    self.alertUser(title: "Error While Getting Data", message: "An error occurred while fetching data from the API: \(error)")
                }
            }
        }
    }

    func addDataLabels() {
        guard let productDetail = productDetail else { return }
        var labelYPosition: CGFloat = 560
        let mirror = Mirror(reflecting: productDetail)
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

    func alertUser(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .default)
        alert.addAction(okay)
        self.present(alert, animated: true)
    }
}

extension AddToAPIViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
