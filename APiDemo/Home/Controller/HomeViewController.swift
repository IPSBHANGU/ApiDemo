//
//  HomeViewController.swift
//  APiDemo
//
//  Created by Inderpreet Singh on 23/02/24.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func publicDataAction(_ sender: Any) {
        let publicDataView = PublicDataViewController()
        navigationController?.pushViewController(publicDataView, animated: true)
    }
    
    @IBAction func catFactAction(_ sender: Any) {
        let catFactView = CatFactViewController()
        navigationController?.pushViewController(catFactView, animated: true)
    }
    
    
    @IBAction func dogImageAction(_ sender: Any) {
        let dogImageView = DogImageViewController()
        navigationController?.pushViewController(dogImageView, animated: true)
    }
    
    
    @IBAction func productsAction(_ sender: Any) {
        let productsView = ProductsViewController()
        navigationController?.pushViewController(productsView, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
