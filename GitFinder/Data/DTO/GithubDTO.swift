//
//  GithubDTO.swift
//  GitFinder
//
//  Created by Vokal-Ican on 05/10/26.
//

import Foundation

struct GithubDTO: Codable {
    let id: Int
    let login: String
    let nodeId: String
    let avatarUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case nodeId = "node_id"
        case avatarUrl = "avatar_url"
    }
}

extension GithubDTO {
    func toDomain() -> Github {
        Github(
            id: id,
            login: login,
            nodeId: nodeId,
            avatarUrl: avatarUrl.flatMap(URL.init(string:))
        )
    }
}
