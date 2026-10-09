//
//  GithubListModuleBuilder.swift
//  GitFinder
//
//  Created by Vokal-Ican on 06/10/26.
//
//

import UIKit

enum GithubListModuleBuilder {
    static func build(
        fetchGithubUseCase: FetchGithubUseCase,
        makeDetailViewController: @escaping (Int) -> UIViewController
    ) -> UIViewController {
        let view = GithubListViewController()
        let interactor = GithubListInteractor(fetchGithubUseCase: fetchGithubUseCase)
        let presenter = GithubListPresenter()
        let router = GithubListRouter(makeDetailViewController: makeDetailViewController)

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}
