//
//  DogImageViewController.swift
//  APiDemo
//
//  Created by Inderpreet Singh on 24/02/24.
//

import UIKit

class DogImageViewController: UIViewController {

    let model = ApiModel()
    let apiUrl = "https://dog.ceo/api/breeds/image/random"
    var dataFromAPI:UIImage?

    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchDatafromAPI()
        let timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(refreshImage), userInfo: nil, repeats: true)
        timer.fire()
    }

    @objc func refreshImage() {
        imageView.image = dataFromAPI
    }


    func fetchDatafromAPI() {
        model.convertDogModelData(url: apiUrl) { isSucceeded, data, error in
            if isSucceeded {
                self.dataFromAPI = data
            } else if let error = error {
                self.alertUser(title: "Error", message: "Error getting data from API: \(error)")
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
