import UIKit

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

struct CatModel: Codable {
    var fact: String?
    var length: Int?
}

struct DogModel: Codable {
    var message: String?
    var status: String?
}

enum httpRequest:String{
    case GET
    case POST
    case PUT
    case DELETE
}

class ApiModel: NSObject {
    func getData(url: String, httpRequest: httpRequest, queryParameters: [String: String]? = nil, completionHandler: @escaping (_ isSucceeded: Bool, _ data: Data?, _ error: String?) -> ()) {
        guard var urlComponents = URLComponents(string: url) else {
            let emptyApiData = Data()
            completionHandler(false, emptyApiData, "Invalid URL")
            return
        }
        
        // Set query parameters if passed as arguement
        if httpRequest == .GET {
            if let queryParameters = queryParameters {
                var queryItems = [URLQueryItem]()
                for (key, value) in queryParameters {
                    queryItems.append(URLQueryItem(name: key, value: value))
                }
                urlComponents.queryItems = queryItems
            }
        }
        
        guard let apiUrl = urlComponents.url else {
            let emptyApiData = Data()
            completionHandler(false, emptyApiData, "Invalid URL")
            return
        }

        var apiUrlRequest = URLRequest(url: apiUrl)
        apiUrlRequest.httpMethod = httpRequest.rawValue
        apiUrlRequest.timeoutInterval = 20
        
        if httpRequest == .POST {
            apiUrlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // Convert the dictionary to JSON data
            guard let parameters = queryParameters else {return}
            guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
                print("Failed to serialize JSON data")
                return
            }
            
            // Set the request body
            apiUrlRequest.httpBody = jsonData
        }
        
        if httpRequest == .PUT {
            apiUrlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // Convert the dictionary to JSON data
            guard let parameters = queryParameters else {return}
            guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
                print("Failed to serialize JSON data")
                return
            }
            
            // Set the request body
            apiUrlRequest.httpBody = jsonData
        }
        
        print(apiUrlRequest)
        
        let task = URLSession.shared.dataTask(with: apiUrlRequest) { data, response, error in
            if let error = error {
                let emptyApiData = Data()
                print("Error while url session \(error)")
                completionHandler(false, emptyApiData, "\(error)")
                return
            }
            
            // Check for internet Connectivity give exist if no internet
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                completionHandler(false, nil, "No Internet Connection")
                return
            }
            
            if let data = data {
                completionHandler(true, data, nil)
            }
        }
        task.resume()
    }
    
    func convertPublicData(url: String, completionHandler: @escaping (_ isSucceeded: Bool, _ data: [EntryObject]?, _ error: String?)->()) {
        getData(url: url, httpRequest: httpRequest.GET) { isSucceeded, data, error in
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
    
    func convertCatModelData(url: String, completionHandler: @escaping (_ isSucceeded: Bool, _ data: [CatModel]?, _ error: String?)->()) {
        getData(url: url, httpRequest: httpRequest.GET) { isSucceeded, data, error in
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
    
    func convertDogModelData(url: String, completionHandler: @escaping (_ isSucceeded: Bool, _ data: [DogModel]?, _ error: String?)->()) {
        getData(url: url, httpRequest: httpRequest.GET) { isSucceeded, data, error in
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
