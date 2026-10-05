//
//  Endpoint.swift
//  GitFinder
//
//  Created by Vokal-Ican on 05/10/26.
//

import Foundation

enum Endpoint {
    case getGithub
    
    private static let baseURL = "https://api.github.com/users"
    
    func url() -> URL? {
        switch self {
        case .getGithub:
            let components = URLComponents(string: Self.baseURL)
            return components?.url
        }
    }
}
