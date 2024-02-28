//
//  CatFactModel.swift
//  APiDemo
//
//  Created by Inderpreet Singh on 28/02/24.
//

import Foundation

struct CatModel: Codable {
    var fact: String?
    var length: Int?
}

class CatFactModel: NSObject {
    func getCatData(url: String, completionHandler: @escaping (_ isSucceeded: Bool, _ data: [CatModel]?, _ error: String?)->()) {
        Network.connectWithServer(url: url, httpRequest: .GET) { isSucceeded, data, error in
            if isSucceeded {
                do {
                    let decoder = JSONDecoder()
                    let usableData = try decoder.decode(CatModel.self, from: data!)
                    completionHandler(true, [usableData], nil)
                } catch {
                    completionHandler(false, nil, error.localizedDescription)
                }
            } else {
                completionHandler(false, nil, error)
            }
        }
    }
}
