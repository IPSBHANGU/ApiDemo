//
//  ViewController.swift
//  APiDemo
//
//  Created by Inderpreet Singh on 22/02/24.
//

import UIKit

class ViewController: UIViewController {

    // call Model
    let model = ApiModel()
    //let url = "https://api.restful-api.dev/objects"
    let url = "https://api.publicapis.org/entries"
//    var dataFromAPI: [[String: Any]] = []
    // activity indicator
    
    var entriesArray = [EntryObject]()
    var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var apiTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchDatafromAPI()
        setupTableView()
        setupActivityIndicator()
        
        let timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(refreshTableView), userInfo: nil, repeats: true)
        timer.fire()
    }

    @objc func refreshTableView() {
        apiTableView.reloadData()
    }
    
    func fetchDatafromAPI() {
        model.convertPublicData(url: url) { isSucceeded, data, error in
            if isSucceeded {
                self.entriesArray = data
            } else if let error = error {
                self.alertUser(title: "Error While Getting Data", message: "An error occurred while fetching data from the API: \(error)")
            }
        }
    }
    
    func setupTableView(){
        apiTableView.delegate = self
        apiTableView.dataSource = self
        apiTableView.register(UINib.init(nibName: "apiTableViewCell", bundle: nil), forCellReuseIdentifier: "apiTableView")
    }
    
    func setupActivityIndicator(){
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
    
    func startLoading() {
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
        apiTableView.alpha = 0
     }

     func stopLoading() {
         self.activityIndicator.stopAnimating()
         self.view.isUserInteractionEnabled = true
         self.apiTableView.alpha = 1
         self.apiTableView.reloadData()
     }
    
    
    func alertUser(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okay = UIAlertAction(title: "Okay", style: .default)
        alert.addAction(okay)
        self.present(alert, animated: true)
    }
    
}

extension ViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entriesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "apiTableView", for: indexPath) as? apiTableViewCell else { return UITableViewCell() }

        let apiResult = entriesArray[indexPath.row]
        
        cell.setupCellView(id: apiResult.API ?? "", name: apiResult.Description ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailDataView = DataDetailsViewController()
        detailDataView.singleData = entriesArray[indexPath.row]
        
        navigationController?.pushViewController(detailDataView, animated: true)
    }
    
}
