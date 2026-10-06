//
//  GithubListViewController.swift
//  GitFinder
//
//  Created by Vokal-Ican on 05/10/26.
//
import UIKit

protocol GithubListViewProtocol: AnyObject {
    func showLoading()
    func showList()
    func showEmpty()
    func showError(_ message: String)
}

final class GithubListViewController: UIViewController {

    var presenter: GithubListPresenterProtocol!

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(GithubCells.self, forCellReuseIdentifier: GithubCells.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "GitFinder"
        view.backgroundColor = .systemBackground

        tableView.dataSource = self
        tableView.delegate = self

        view.addSubview(tableView)
        view.addSubview(loadingIndicator)
        view.addSubview(statusLabel)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            statusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
        ])

        presenter.viewDidLoad()
    }
}

extension GithubListViewController: GithubListViewProtocol {
    func showLoading() {
        tableView.isHidden = true
        statusLabel.isHidden = true
        loadingIndicator.startAnimating()
    }

    func showList() {
        loadingIndicator.stopAnimating()
        statusLabel.isHidden = true
        tableView.isHidden = false
        tableView.reloadData()
    }

    func showEmpty() {
        loadingIndicator.stopAnimating()
        tableView.isHidden = true
        statusLabel.isHidden = false
        statusLabel.text = "No users found."
    }

    func showError(_ message: String) {
        loadingIndicator.stopAnimating()
        tableView.isHidden = true
        statusLabel.isHidden = false
        statusLabel.text = message
    }
}

extension GithubListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfItems()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: GithubCells.reuseIdentifier,
            for: indexPath
        ) as? GithubCells else {
            return UITableViewCell()
        }
        cell.configure(with: presenter.github(at: indexPath.row))
        return cell
    }
}

extension GithubListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectGithub(at: indexPath.row)
    }
}
