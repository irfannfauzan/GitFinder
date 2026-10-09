//
//  GithubRepositoryProtocol.swift
//  GitFinder
//
//  Created by Vokal-Ican on 05/10/26.
//

protocol GithubRepositoryProtocol {
    func getGithub() async throws -> [Github]
    func getGithubDetail(id: Int) async throws -> Github
}
