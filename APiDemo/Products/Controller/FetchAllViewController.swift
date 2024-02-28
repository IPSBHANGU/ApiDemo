//
//  FetchAllViewController.swift
//  APiDemo
//
//  Created by Inderpreet Singh on 26/02/24.
//

import UIKit

class FetchAllViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // call Model
    let model = ProductsModel()
    var entriesArray = [ProductsDetail]()
    var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchDatafromAPI()
        setupTableView()
        // Do any additional setup after loading the view.
    }

    func fetchDatafromAPI() {
        model.convertProductsModelData() { isSucceeded, data, error in
            DispatchQueue.main.async {
                if isSucceeded {
                    guard let data = data else {return}
                    self.entriesArray = data
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.removeFromSuperview()
                } else if let error = error {
                    AlerUser.alertUser(viewController: self, title: "Error While Getting Data", message: "An error occurred while fetching data from the API: \(error)")
                }
            }
        }
    }
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "FetchAllTableViewCell", bundle: nil), forCellReuseIdentifier: "fetchAllView")
        addLoader(cgPoint: CGPoint(x: tableView.bounds.midX, y: tableView.bounds.midY))
        tableView.addSubview(activityIndicator)
    }
    
    func addLoader(cgPoint:CGPoint){
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = cgPoint
        activityIndicator.color = .black
        activityIndicator.startAnimating()
    }
}

extension FetchAllViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entriesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "fetchAllView", for: indexPath) as? FetchAllTableViewCell else { return UITableViewCell() }
        
        let apiResult = entriesArray[indexPath.row]
        
        cell.setupCellView(title: apiResult.title ?? "" , description: apiResult.description ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = entriesArray[indexPath.row].id
        let detailView = DetailViewController()
        model.getSingleProductsModelData(id: "\(id ?? 0)") { isSucceeded, data, error in
            DispatchQueue.main.async {
                if isSucceeded {
                    guard let data = data else {return}
                    detailView.productDetail = [data]
                    self.navigationController?.pushViewController(detailView, animated: true)
                } else if let error = error {
                    AlerUser.alertUser(viewController: self, title: "Error While Getting Data", message: "An error occurred while fetching data from the API: \(error)")
                }
            }
        }
    }
}
