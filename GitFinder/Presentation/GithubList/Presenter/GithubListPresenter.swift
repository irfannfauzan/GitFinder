//
//  GithubListPresenter.swift
//  GitFinder
//
//  Created by Vokal-Ican on 06/10/26.
//

import Foundation

protocol GithubListPresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfItems() -> Int
    func github(at index: Int) -> Github
    func didSelectGithub(at index: Int)
}

final class GithubListPresenter {

    weak var view: GithubListViewProtocol?
    var interactor: GithubListInteractorProtocol!
    var router: GithubListRouterProtocol!

    private var githubs: [Github] = []
}

extension GithubListPresenter: GithubListPresenterProtocol {
    func viewDidLoad() {
        view?.showLoading()
        interactor.fetchGithubList()
    }

    func numberOfItems() -> Int {
        githubs.count
    }

    func github(at index: Int) -> Github {
        githubs[index]
    }

    func didSelectGithub(at index: Int) {
        router.navigateToDetail(of: githubs[index])
    }
}

extension GithubListPresenter: GithubListInteractorOutputProtocol {
    func didFetchGithubList(_ githubs: [Github]) {
        self.githubs = githubs
        if githubs.isEmpty {
            view?.showEmpty()
        } else {
            view?.showList()
        }
    }

    func didFailFetchingGithubList(_ message: String) {
        view?.showError(message)
    }
}
