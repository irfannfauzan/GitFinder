//
//  GithubDetailRouter.swift
//  GitFinder
//
//  Created by Vokal-Ican on 09/10/26.
//

import UIKit

protocol GithubDetailRouterProtocol: AnyObject {
    func openProfile(of detail: Github)
}

final class GithubDetailRouter: GithubDetailRouterProtocol {
    func openProfile(of detail: Github) {
        guard let url = detail.htmlUrl else { return }
        UIApplication.shared.open(url)
    }
}
