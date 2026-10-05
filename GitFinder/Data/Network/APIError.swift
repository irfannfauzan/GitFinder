//
//  APIError.swift
//  GitFinder
//
//  Created by Vokal-Ican on 05/10/26.
//

import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case transport(Error)
    case invalidResponse
    case httpStatus(Int)
    case decoding(Error)
    
    var errorDescription: String? {
        switch self {
        case.invalidURL:
            return "invalidURL"
        case.transport:
            return "transport"
        case.invalidResponse:
            return "invalidResponse"
        case.httpStatus(let code):
            return "httpStatus \(code)"
        case.decoding(let error):
            return "decoding error:\(error.localizedDescription)"
        }
    }
}
