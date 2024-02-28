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
        
        func name() -> String {
            switch self {
            case .publicEntries:
                return "entries"
            }
        }
        
        func baseUrl() -> String {
            switch self {
            case .publicEntries:
                return "https://api.publicapis.org/"
            }
        }
        
        func apiUrl() -> String {
            switch self {
            case .publicEntries:
                return "\(baseUrl())\(name())"
            }
        }
    }
}
