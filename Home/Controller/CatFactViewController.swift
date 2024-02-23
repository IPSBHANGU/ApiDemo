//
//  CatFactViewController.swift
//  APiDemo
//
//  Created by Inderpreet Singh on 23/02/24.
//

import UIKit

class CatFactViewController: UIViewController {

    // call Model
    let model = ApiModel()
    let url = "https://catfact.ninja/fact"
    var dataFromAPI: [String: Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchDatafromAPI()
        addDataLabels()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        addDataLabels()
    }
    
    func fetchDatafromAPI() {
        model.hitAPI(url: url) { isSucceeded, data, error in
            if isSucceeded {
                //self.dataFromAPI = data
                print(data)
            } else if let error = error {
                self.alertUser(title: "Error While Getting Data", message: "An error occurred while fetching data from the API: \(error)")
            }
        }
    }

    func addDataLabels() {
        var labelYPosition: CGFloat = 100
        for (key, value) in dataFromAPI {
            let label = UILabel(frame: CGRect(x: 20, y: labelYPosition, width: 250, height: 30))
            print("\(key ) \(value)")
            label.text = "\(key): \(value)"
            self.view.addSubview(label)
            labelYPosition += 40
        }
    }

    func alertUser(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okay = UIAlertAction(title: "Okay", style: .default)
        alert.addAction(okay)
        self.present(alert, animated: true)
    }

}
