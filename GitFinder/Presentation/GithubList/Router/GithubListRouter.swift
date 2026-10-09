//
//  GithubListRouter.swift
//  GitFinder
//
//  Created by Vokal-Ican on 06/10/26.
//

import UIKit

protocol GithubListRouterProtocol: AnyObject {
    func navigateToDetail(of github: Github)
}

final class GithubListRouter: GithubListRouterProtocol {

    weak var viewController: UIViewController?
    private let makeDetailViewController: (Int) -> UIViewController
    
    init(makeDetailViewController: @escaping (Int) -> UIViewController) {
        self.makeDetailViewController = makeDetailViewController
    }

    func navigateToDetail(of github: Github) {
        let detail = makeDetailViewController(github.id)
        viewController?.navigationController?.pushViewController(detail, animated: true)
    }
}
//
//final class GithubListRouter: GithubListRouterProtocol {
//
//    weak var viewController: UIViewController?
//
//    func navigateToDetail(of github: Github) {
//        // placeholder, belum ada screen detail
//        print("navigate to detail: \(github.login)")
//        let detail = GithubDetailViewController()
//        viewController?.navigationController?.pushViewController(detail, animated: true)
//        
//    }
//}
