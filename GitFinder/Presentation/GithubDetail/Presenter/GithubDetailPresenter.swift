//
//  GithubDetailPresenter.swift
//  GitFinder
//
//  Created by Vokal-Ican on 09/10/26.
//
//
import Foundation

protocol GithubDetailPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapOpenProfile()
}

final class GithubDetailPresenter {
    weak var view: GithubDetailViewProtocol?
    var interactor: GithubDetailInteractorProtocol!
    var router: GithubDetailRouterProtocol!
    
    private var detail: Github?
}

extension GithubDetailPresenter: GithubDetailPresenterProtocol {
    func viewDidLoad() {
        view?.showLoading()
        interactor.getGithubDetail()
    }
    
    func didTapOpenProfile() {
        guard let detail else { return }
        router.openProfile(of: detail)
    }
}

extension GithubDetailPresenter: GithubDetailInteractorOutputProtocol {
    func didFetchGithubDetail(_ githubs: Github) {
        self.detail = githubs
        view?.showDetail(githubs)
    }
    
    func didFailFetchingGithubDetail(_ message: String?) {
        view?.showError(message ?? "something error")
    }
}
