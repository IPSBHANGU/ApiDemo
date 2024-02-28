//
//  QueryViewController.swift
//  APiDemo
//
//  Created by Inderpreet Singh on 27/02/24.
//

import UIKit

class QueryViewController: UIViewController {

    
    @IBOutlet weak var limitTextField: UITextField!
    @IBOutlet weak var brandTextField: UITextField!
    
    // call model
    let model = ProductsModel()
    var productDetail = [ProductsDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTextFields()
        // Do any additional setup after loading the view.
    }

    func setupTextFields(){
        limitTextField.delegate = self
        brandTextField.delegate = self
    }
    
    @IBAction func searchAction(_ sender: Any) {
        let limit:Int = Int(limitTextField.text ?? "") ?? 0
        model.queryParamsModelData(limit: limit, key: brandTextField.text ?? "") { isSucceeded, data, error in
            DispatchQueue.main.async {
                if isSucceeded {
                    guard let data = data else {return}
                    self.productDetail = data
                    self.addDataLabels()
                } else if let error = error {
                    AlerUser.alertUser(viewController: self, title: "Error While Getting Data", message: "An error occurred while fetching data from the API: \(error)")
                }
            }
        }
    }
    
    func addDataLabels() {
        var labelYPosition: CGFloat = 360
        
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
extension QueryViewController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
