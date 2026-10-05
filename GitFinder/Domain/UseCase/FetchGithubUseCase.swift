//
//  FetchGithubUseCase.swift
//  GitFinder
//
//  Created by Vokal-Ican on 05/10/26.
//

final class FetchGithubUseCase {
    private let repository: GithubRepositoryProtocol
    
    init(repository: GithubRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws -> [Github] {
        try await repository.getGithub()
    }
}
