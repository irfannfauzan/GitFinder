//
//  Github.swift
//  GitFinder
//
//  Created by Vokal-Ican on 05/10/26.
//

import Foundation

struct Github: Equatable, Hashable {
    let id: Int
    let login: String
    let nodeId: String
    let avatarUrl: URL?
}
