//
//  GithubDetailInteractor.swift
//  GitFinder
//
//  Created by Vokal-Ican on 09/10/26.
//

import Foundation

//interactor protocol
protocol GithubDetailInteractorProtocol: AnyObject {
    func getGithubDetail()
}

// output protocol
protocol GithubDetailInteractorOutputProtocol: AnyObject {
    func didFetchGithubDetail(_ githubs: Github)
    func didFailFetchingGithubDetail(_ message: String?)
}

final class GithubDetailInteractor: GithubDetailInteractorProtocol {
    weak var presenter: GithubDetailInteractorOutputProtocol?
    
    private let idGithub: Int
    
    private let fetchGithubDetailUseCase: FetchGithubDetailUseCase
    
    init(idGithub: Int, fetchGithubDetailUseCase: FetchGithubDetailUseCase) {
        self.idGithub = idGithub
        self.fetchGithubDetailUseCase = fetchGithubDetailUseCase
    }
    
    func getGithubDetail() {
        Task { [weak self] in
            guard let self else { return }
            do {
                let result = try await self.fetchGithubDetailUseCase.execute(id: self.idGithub)
                await MainActor.run {
                    self.presenter?.didFetchGithubDetail(result)
                }
            } catch {
                await MainActor.run {
                    self.presenter?.didFailFetchingGithubDetail(error.localizedDescription)
                }
            }
        }
    }
    
}
