//
//  GithubRepository.swift
//  GitFinder
//
//  Created by Vokal-Ican on 05/10/26.
//

final class GithubRepository: GithubRepositoryProtocol {
    
    private let apiClient: ApiClientProtocol
    
    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }
    
    func getGithub() async throws -> [Github] {
        let response: [GithubDTO] = try await apiClient.get(.getGithub)
        let result = response.map { $0.toDomain() }
        return result
    }
    
    func getGithubDetail(id: Int) async throws -> Github {
        let response: GithubDTO = try await apiClient.get(.getGithubDetail(id: id))
        return response.toDomain()
    }
}
