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
    var dataFromAPI = [DogModel]()
    let image = UIImageView()
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchDatafromAPI()
        let timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(refreshImage), userInfo: nil, repeats: true)
        timer.fire()
    }

    @objc func refreshImage() {
        fetchDatafromAPI()
    }


    func fetchDatafromAPI() {
        model.convertDogModelData(url: apiUrl) { isSucceeded, data, error in
            DispatchQueue.main.async{
                if isSucceeded {
                    guard let data = data else {return}
                    self.dataFromAPI = data
                    self.imageView.downloaded(from: data[0].message!)
                } else if let error = error {
                    self.alertUser(title: "Error", message: "Error getting data from API: \(error)")
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
