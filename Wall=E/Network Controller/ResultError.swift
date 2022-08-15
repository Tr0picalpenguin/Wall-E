//
//  ResultError.swift
//  Wall-E
//
//  Created by Scott Cox on 8/7/22.
//

import Foundation

enum ResultError: LocalizedError {
    case noData
    case unableToDecode
    case invalidURL
    case thrownError(Error)
    
    var errorDescription: String? {
        switch self {
        case .noData:
            return "The server responded with no data. Try again."
        case .unableToDecode:
            return "Unable to decode the object. Check the data from your endpoint."
        case .invalidURL:
            return "Unable to reach the server. Check the url"
        case .thrownError(let error):
            return "Error: \(error.localizedDescription) -> \(error)"
        }
    }
}

