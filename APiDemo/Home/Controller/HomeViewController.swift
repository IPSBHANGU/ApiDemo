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
        let actionSheet = UIAlertController(title: "Products View", message: "Select Option from below for action to perform!", preferredStyle: .actionSheet)
        
        // fetchAll
        actionSheet.addAction(UIAlertAction(title: "Fetch All", style: .default, handler: { (_) in
            let fetchAllView = FetchAllViewController()
            self.navigationController?.pushViewController(fetchAllView, animated: true)
        }))
        
        // query
        actionSheet.addAction(UIAlertAction(title: "Query", style: .default, handler: { (_) in
            let queryView = QueryViewController()
            self.navigationController?.pushViewController(queryView, animated: true)
        }))
        
        // add
        actionSheet.addAction(UIAlertAction(title: "Add", style: .default, handler: { (_) in
            let addView = AddToAPIViewController()
            self.navigationController?.pushViewController(addView, animated: true)
        }))
        
        // Add cancel action
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        actionSheet.view.tintColor = .black
        
        // Present the action sheet
        present(actionSheet, animated: true, completion: nil)
    }

}
