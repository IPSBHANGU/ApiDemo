//
//  ApiModel.swift
//  APiDemo
//
//  Created by Inderpreet Singh on 22/02/24.
//

import UIKit

struct DataModel:Codable {
    var count:Int?
    var entries:[EntryObject]
}

struct EntryObject:Codable {
    var API:String?
    var Description:String?
    var Auth:String?
    var HTTPS:Bool?
    var Cors:String?
    var Link:String?
    var Category:String
}

struct CatModel:Codable{
    var fact:String?
    var length:Int?
}

class ApiModel: NSObject {
    func hitAPI(url: String, completionHandler: @escaping(_ isSucceeded: Bool, _ data:Data, _ error: String?)->()) {
        let apiUrl = URL(string: url)
        var apiUrlRequest = URLRequest(url: apiUrl!)
        apiUrlRequest.httpMethod = "GET"
        apiUrlRequest.timeoutInterval = 20
        
        let task = URLSession.shared.dataTask(with: apiUrlRequest) { data, response, error in
            if let error = error {
                let emptyApiData = Data()
                print("Error while url session \(error)")
                completionHandler(false, emptyApiData, "\(error)")
                return
            }
            
            if let data = data {
                completionHandler(true, data, "")
            }
        }
        task.resume()
    }
    
    func convertPublicData(url:String, completionHandler: @escaping(_ isSucceeded: Bool, _ data:[EntryObject], _ error: String?)->()) {
        hitAPI(url: url) { isSucceeded, data, error in
            if isSucceeded {
                do {
                    let decorder = JSONDecoder()
                    let usableData = try decorder.decode(DataModel.self, from: data)
                    let entriesData = usableData.entries
                    completionHandler(true, entriesData, "")
                } catch {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                var emptyDataModel:[EntryObject]?
                completionHandler(false, emptyDataModel!, "\(error)")
            }
        }
    }

    func convertCatModelData(url:String, completionHandler: @escaping(_ isSucceeded: Bool, _ data:[CatModel], _ error: String?)->()) {
        hitAPI(url: url) { isSucceeded, data, error in
            if isSucceeded {
                do {
                    let decorder = JSONDecoder()
                    let usableData = try decorder.decode(CatModel.self, from: data)
                    completionHandler(true, [usableData], "")
                } catch {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                var emptyCatModel:[CatModel]?
                completionHandler(false, emptyCatModel!, "\(error)")
            }
        }
    }
}
