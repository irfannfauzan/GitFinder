//
//  GithubListViewController.swift
//  GitFinder
//
//  Created by Vokal-Ican on 05/10/26.
//

import UIKit

class GithubListViewController: UIViewController {
    
    private let githubs: [Github] = [
        Github(id: 1, login: "id 1", nodeId: "node id 1", avatarUrl: "https://avatars.githubusercontent.com/u/1?v=4"),
        Github(id: 2, login: "id 2", nodeId: "node id 2", avatarUrl: "https://avatars.githubusercontent.com/u/1?v=4"),
        Github(id: 3, login: "id 3", nodeId: "node id 3", avatarUrl: "https://avatars.githubusercontent.com/u/1?v=4"),
    ]
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GithubCells.self, forCellReuseIdentifier: GithubCells.reuseIdentifier)
        
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safe.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
    }
}

extension GithubListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return githubs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GithubCells.reuseIdentifier, for: indexPath) as? GithubCells
        else { return UITableViewCell() }
        
        let github = githubs[indexPath.row]
        cell.configure(with: github)
        
        return cell
    }
}

extension GithubListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

