//
//  ProductsModel.swift
//  APiDemo
//
//  Created by Inderpreet Singh on 26/02/24.
//

import UIKit

struct Products: Codable {
    var products:[ProductsDetail]
}

struct ProductsDetail:Codable {
    var id: Int?
    var title: String?
    var description: String?
    var price: Int?
    var discountPercentage: Float?
    var rating:Float?
    var stock:Int?
    var brand:String?
    var category:String?
    var thumbnail:String?
    var images:[String]?
}

class ProductsModel: NSObject {
    
    let homeModel = ApiModel()
    // url
    let url = "https://dummyjson.com/products"
    
    func convertProductsModelData(completionHandler: @escaping (_ isSucceeded: Bool, _ data: [ProductsDetail]?, _ error: String?)->()) {
        homeModel.getData(url: url, httpRequest: httpRequest.GET) { isSucceeded, data, error in
            if isSucceeded {
                do {
                    let decoder = JSONDecoder()
                    let usableData = try decoder.decode(Products.self, from: data!)
                    print(usableData.products)
                    let entriesData = usableData.products
                    completionHandler(true, entriesData, nil)
                } catch {
                    print(data!)
                    print(error.localizedDescription)
                    completionHandler(false, nil, error.localizedDescription)
                }
            } else {
                completionHandler(false, nil, error)
            }
        }
    }
    
    func getSingleProductsModelData(id:String?, completionHandler: @escaping (_ isSucceeded: Bool, _ data: ProductsDetail?, _ error: String?)->()) {
        var updatedURL = url
        updatedURL = updatedURL + "/"
        updatedURL.append(id ?? "")
        print(updatedURL)
        homeModel.getData(url: updatedURL, httpRequest: httpRequest.GET) { isSucceeded, data, error in
            if isSucceeded {
                do {
                    let decoder = JSONDecoder()
                    let usableData = try decoder.decode(ProductsDetail.self, from: data!)
                    completionHandler(true, usableData, nil)
                } catch {
                    print(data!)
                    print(error.localizedDescription)
                    completionHandler(false, nil, error.localizedDescription)
                }
            } else {
                completionHandler(false, nil, error)
            }
        }
    }
    
    func searchProductsModelData(search: String, completionHandler: @escaping (_ isSucceeded: Bool, _ data: [ProductsDetail]?, _ error: String?) -> ()) {
        var updatedURL = url
        updatedURL = updatedURL + "/search/"
        
        // query parameters
        let queryParameters = ["q": search]
        
        homeModel.getData(url: updatedURL, httpRequest: .GET, queryParameters: queryParameters) { isSucceeded, data, error in // Passing .POST as httpRequest
            if isSucceeded {
                do {
                    let decoder = JSONDecoder()
                    let usableData = try decoder.decode(Products.self, from: data!)
                    let entriesData = usableData.products
                    completionHandler(true, entriesData, nil)
                } catch {
                    print(data!)
                    print(error.localizedDescription)
                    completionHandler(false, nil, error.localizedDescription)
                }
            } else {
                completionHandler(false, nil, error)
            }
        }
    }
    
    func queryParamsModelData(limit: Int, key:String, completionHandler: @escaping (_ isSucceeded: Bool, _ data: [ProductsDetail]?, _ error: String?) -> ()) {
        
        // query parameters
        let queryParameters = [
            "limit": "\(limit)",
            "skip": "\(0)",
            "select": key
        ]
        
        homeModel.getData(url: url, httpRequest: .GET, queryParameters: queryParameters) { isSucceeded, data, error in // Passing .GET as httpRequest
            if isSucceeded {
                do {
                    let decoder = JSONDecoder()
                    let usableData = try decoder.decode(Products.self, from: data!)
                    let entriesData = usableData.products
                    completionHandler(true, entriesData, nil)
                } catch {
                    print(data!)
                    print(error.localizedDescription)
                    completionHandler(false, nil, error.localizedDescription)
                }
            } else {
                completionHandler(false, nil, error)
            }
        }
    }
    
    func addPostModelData(key:String, keyValue:String, completionHandler: @escaping (_ isSucceeded: Bool, _ data: ProductsDetail?, _ error: String?) -> ()) {
        
        //  dictionary for the request body
        let parameters = [
            key: keyValue
        ]
        
        // update url
        var updatedURL = url
        updatedURL = updatedURL + "/add"
        
        homeModel.getData(url: updatedURL, httpRequest: .POST, queryParameters: parameters) { isSucceeded, data, error in // Passing .POST as httpRequest
            if isSucceeded {
                do {
                    let decoder = JSONDecoder()
                    let usableData = try decoder.decode(ProductsDetail.self, from: data!)
                    let entriesData = usableData
                    completionHandler(true, entriesData, nil)
                } catch {
                    print(error.localizedDescription)
                    completionHandler(false, nil, error.localizedDescription)
                }
            } else {
                completionHandler(false, nil, error)
            }
        }
    }
    
    func updatePostModelData(productID:Int, key:String, keyValue:String, completionHandler: @escaping (_ isSucceeded: Bool, _ data: ProductsDetail?, _ error: String?) -> ()) {
        
        //  dictionary for the request body
        let parameters = [
            key: keyValue
        ]
        
        // update url
        var updatedURL = url
        updatedURL = updatedURL + "/"
        updatedURL = updatedURL + "\(productID)"
        
        homeModel.getData(url: updatedURL, httpRequest: .PUT, queryParameters: parameters) { isSucceeded, data, error in // Passing .PUT as httpRequest
            if isSucceeded {
                do {
                    let decoder = JSONDecoder()
                    let usableData = try decoder.decode(ProductsDetail.self, from: data!)
                    let entriesData = usableData
                    completionHandler(true, entriesData, nil)
                } catch {
                    print(error.localizedDescription)
                    completionHandler(false, nil, error.localizedDescription)
                }
            } else {
                completionHandler(false, nil, error)
            }
        }
    }
    
    func deleteModelData(productID:Int, completionHandler: @escaping (_ isSucceeded: Bool, _ data: ProductsDetail?, _ error: String?) -> ()) {
        
        // update url
        var updatedURL = url
        updatedURL = updatedURL + "/"
        updatedURL = updatedURL + "\(productID)"
        
        homeModel.getData(url: updatedURL, httpRequest: .DELETE) { isSucceeded, data, error in // Passing .DELETE as httpRequest
            if isSucceeded {
                do {
                    let decoder = JSONDecoder()
                    let usableData = try decoder.decode(ProductsDetail.self, from: data!)
                    let entriesData = usableData
                    completionHandler(true, entriesData, nil)
                } catch {
                    print(error.localizedDescription)
                    completionHandler(false, nil, error.localizedDescription)
                }
            } else {
                completionHandler(false, nil, error)
            }
        }
    }
}
