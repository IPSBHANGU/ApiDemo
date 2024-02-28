//
//  PublicDataViewController.swift
//  APiDemo
//
//  Created by Inderpreet Singh on 28/02/24.
//

import UIKit

class PublicDataViewController: UIViewController {

    // call Model
    let model = PublicModel()
    var entriesArray = [EntryObject]()
    var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var apiTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchDatafromAPI()
        setupTableView()
    }


    func fetchDatafromAPI() {
        model.getPublicData(url: APIConstant.API.publicEntries.apiUrl()) { isSucceeded, data, error in
            DispatchQueue.main.async {
                if isSucceeded {
                    guard let data = data else {return}
                    self.entriesArray = data
                    self.apiTableView.reloadData()
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.removeFromSuperview()
                } else if let error = error {
                    AlerUser.alertUser(viewController: self, title: "Error While Getting Data", message: "An error occurred while fetching data from the API: \(error)")
                }
            }
        }
    }
    
    func setupTableView(){
        apiTableView.delegate = self
        apiTableView.dataSource = self
        apiTableView.register(UINib.init(nibName: "PublicDataTableViewCell", bundle: nil), forCellReuseIdentifier: "PublicDataTableView")
        addLoader(cgPoint: CGPoint(x: apiTableView.bounds.midX, y: apiTableView.bounds.midY))
        apiTableView.addSubview(activityIndicator)
    }
    
    func addLoader(cgPoint:CGPoint){
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = cgPoint
        activityIndicator.color = .black
        activityIndicator.startAnimating()
    }
}

extension PublicDataViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entriesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PublicDataTableView", for: indexPath) as? PublicDataTableViewCell else { return UITableViewCell() }

        let apiResult = entriesArray[indexPath.row]
        
        cell.setupCellView(id: apiResult.API ?? "", name: apiResult.Description ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailDataView = PublicDataDetailsViewController()
        detailDataView.singleData = entriesArray[indexPath.row]
        
        navigationController?.pushViewController(detailDataView, animated: true)
    }
    
}

