//
//  FetchGithubDetailUseCase.swift
//  GitFinder
//
//  Created by Vokal-Ican on 09/10/26.
//

final class FetchGithubDetailUseCase {
    private let repository: GithubRepositoryProtocol
    
    init(repository: GithubRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(id: Int) async throws -> Github {
        try await repository.getGithubDetail(id: id)
    }
}
