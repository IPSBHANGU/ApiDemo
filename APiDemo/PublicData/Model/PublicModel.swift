//
//  PublicModel.swift
//  APiDemo
//
//  Created by Inderpreet Singh on 28/02/24.
//

import Foundation

struct DataModel: Codable {
    var count: Int?
    var entries: [EntryObject]
}

struct EntryObject: Codable {
    var API: String?
    var Description: String?
    var Auth: String?
    var HTTPS: Bool?
    var Cors: String?
    var Link: String?
    var Category: String
}

class PublicModel:NSObject {
    func getPublicData(url: String, completionHandler: @escaping (_ isSucceeded: Bool, _ data: [EntryObject]?, _ error: String?)->()) {
        
        Network.connectWithServer(url: url, httpRequest: .GET) { isSucceeded, data, error in
            if isSucceeded {
                do {
                    let decoder = JSONDecoder()
                    let usableData = try decoder.decode(DataModel.self, from: data!)
                    let entriesData = usableData.entries
                    completionHandler(true, entriesData, nil)
                } catch {
                    completionHandler(false, nil, error.localizedDescription)
                }
            } else {
                completionHandler(false, nil, error)
            }
        }
    }
    
}
