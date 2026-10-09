//
//  GithubDetailModuleBuilder.swift
//  GitFinder
//
//  Created by Vokal-Ican on 09/10/26.
//

import UIKit

enum GithubDetailModuleBuilder {
    static func build(
        idGithub: Int,
        fetchGithubDetailUseCase: FetchGithubDetailUseCase
    ) -> UIViewController {
        let view = GithubDetailViewController()
        let interactor = GithubDetailInteractor(
            idGithub: idGithub,
            fetchGithubDetailUseCase: fetchGithubDetailUseCase
        )
        let presenter = GithubDetailPresenter()
        let router = GithubDetailRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter

        return view
    }
}
