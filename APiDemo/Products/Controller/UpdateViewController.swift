//
//  UpdateViewController.swift
//  APiDemo
//
//  Created by Inderpreet Singh on 27/02/24.
//

import UIKit

class UpdateViewController: UIViewController {

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
        model.updatePostModelData(productID: 4, key: key ?? "", keyValue: keyValue) { isSucceeded, data, error in
            DispatchQueue.main.async {
                if isSucceeded {
                    self.productDetail = data
                    self.addDataLabels()
                } else if let error = error {
                    AlerUser.alertUser(viewController: self, title: "Error While Getting Data", message: "An error occurred while fetching data from the API: \(error)")
                }
            }
        }
    }
    
    func addDataLabels() {
        guard let productDetail = productDetail else { return }
        var labelYPosition: CGFloat = 460
        let mirror = Mirror(reflecting: productDetail)
        for case let (label?, value) in mirror.children {
            if let stringValue = value as? String {
                let labelText = "\(label): \(stringValue)"
                let label = UILabel(frame: CGRect(x: 20, y: labelYPosition, width: 350, height: 30))
                label.text = labelText
                self.view.addSubview(label)
                labelYPosition += 40
            }
        }
    }
}

extension UpdateViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
