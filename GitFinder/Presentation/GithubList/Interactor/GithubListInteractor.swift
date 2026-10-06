//
//  GithubListInteractor.swift
//  GitFinder
//
//  Created by Vokal-Ican on 06/10/26.
//

import Foundation

protocol GithubListInteractorProtocol: AnyObject {
    func fetchGithubList()
}

protocol GithubListInteractorOutputProtocol: AnyObject {
    func didFetchGithubList(_ githubs: [Github])
    func didFailFetchingGithubList(_ message: String)
}

final class GithubListInteractor: GithubListInteractorProtocol {

    weak var presenter: GithubListInteractorOutputProtocol?

    private let fetchGithubUseCase: FetchGithubUseCase

    init(fetchGithubUseCase: FetchGithubUseCase) {
        self.fetchGithubUseCase = fetchGithubUseCase
    }

    func fetchGithubList() {
        Task { [weak self] in
            guard let self else { return }
            do {
                let result = try await self.fetchGithubUseCase.execute()
                await MainActor.run {
                    self.presenter?.didFetchGithubList(result)
                }
            } catch {
                await MainActor.run {
                    self.presenter?.didFailFetchingGithubList(error.localizedDescription)
                }
            }
        }
    }
}
