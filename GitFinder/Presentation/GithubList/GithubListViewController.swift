//
//  GithubListViewController.swift
//  GitFinder
//
//  Created by Vokal-Ican on 05/10/26.
//

import UIKit

class GithubListViewController: UIViewController {
    
    private let githubs: [Github] = [
        Github(Id: 1, Login: "id 1", nodeId: "node id 1", avatarUrl: "https://avatars.githubusercontent.com/u/1?v=4"),
        Github(Id: 2, Login: "id 2", nodeId: "node id 2", avatarUrl: "https://avatars.githubusercontent.com/u/1?v=4"),
        Github(Id: 3, Login: "id 3", nodeId: "node id 3", avatarUrl: "https://avatars.githubusercontent.com/u/1?v=4"),
    ]
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GithubCells.self, forCellReuseIdentifier: GithubCells.reuseIdentifier)
        
        NSLayoutConstraint.activate([
            //
        ])
        
    }
}

extension GithubListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return githubs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        return UITableViewCell()
    }
}

extension GithubListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

