//
//  AlerUser.swift
//  APiDemo
//
//  Created by Inderpreet Singh on 28/02/24.
//

import Foundation
import UIKit

class AlerUser:NSObject {
    static func alertUser(viewController:UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okay = UIAlertAction(title: "Okay", style: .default)
        alert.addAction(okay)
        viewController.present(alert, animated: true)
    }
}
