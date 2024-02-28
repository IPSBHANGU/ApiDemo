//
//  DogImage.swift
//  APiDemo
//
//  Created by Inderpreet Singh on 28/02/24.
//

import Foundation

struct DogModel: Codable {
    var message: String?
    var status: String?
}

class DogImage:NSObject {
    func getDogData(url: String, completionHandler: @escaping (_ isSucceeded: Bool, _ data: [DogModel]?, _ error: String?)->()) {
        Network.connectWithServer(url: url, httpRequest: .GET) { isSucceeded, data, error in
            if isSucceeded {
                do {
                    let decoder = JSONDecoder()
                    let usableData = try decoder.decode(DogModel.self, from: data!)
                    completionHandler(true, [usableData], "")
                } catch {
                    completionHandler(false, nil, error.localizedDescription)
                }
            } else {
                completionHandler(false, nil, error)
            }
        }
    }

}
