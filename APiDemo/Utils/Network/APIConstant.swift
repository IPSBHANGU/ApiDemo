//
//  APIConstant.swift
//  APiDemo
//
//  Created by Inderpreet Singh on 28/02/24.
//

import Foundation


class APIConstant {
    
    enum API {
        case publicEntries
        case CatFact
        case DogImage
        case Products
        
        func name() -> String {
            switch self {
            case .publicEntries:
                return "entries"
            case .CatFact:
                return "fact"
            case .DogImage:
                return "random"
            case .Products:
                return "products"
            }
        }
        
        func baseUrl() -> String {
            switch self {
            case .publicEntries:
                return "https://api.publicapis.org/"
            case .CatFact:
                return "https://catfact.ninja/"
            case .DogImage:
                return "https://dog.ceo/api/breeds/image/"
            case .Products:
                return "https://dummyjson.com/"
            }
        }
        
        func apiUrl() -> String {
            return "\(baseUrl())\(name())"
        }
    }
}
