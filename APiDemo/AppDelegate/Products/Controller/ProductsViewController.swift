//
//  ProductsViewController.swift
//  APiDemo
//
//  Created by Inderpreet Singh on 26/02/24.
//

import UIKit

class ProductsViewController: UIViewController {

    @IBOutlet weak var serachBar: UISearchBar!
    
    // call model
    let model = ProductsModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchBar()
        // Do any additional setup after loading the view.
    }

    @IBAction func fetchAllAction(_ sender: UIButton) {
        let fetchAllView = FetchAllViewController()
        navigationController?.pushViewController(fetchAllView, animated: true)
    }

    func setupSearchBar(){
        serachBar.delegate = self
    }
    
    @IBAction func queryAction(_ sender: UIButton) {
        let queryView = QueryViewController()
        navigationController?.pushViewController(queryView, animated: true)
    }
    
    func alertUser(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okay = UIAlertAction(title: "Okay", style: .default)
        alert.addAction(okay)
        self.present(alert, animated: true)
    }

}

extension ProductsViewController:UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let detailView = DetailViewController()
        model.searchProductsModelData(search: searchBar.text ?? "") { isSucceeded, data, error in
            DispatchQueue.main.async {
                if isSucceeded {
                    guard let data = data else {return}
                    detailView.productDetail = data
                    self.navigationController?.pushViewController(detailView, animated: true)
                } else if let error = error {
                    self.alertUser(title: "Error While Getting Data", message: "An error occurred while fetching data from the API: \(error)")
                }
            }
        }
    }
}
